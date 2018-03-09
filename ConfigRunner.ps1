# $secpasswd = ConvertTo-SecureString "PlainTextPassword" -AsPlainText -Force
# $mycreds = New-Object System.Management.Automation.PSCredential ("username", $secpasswd)

$catsRunnerSourceDir = "\\Csicesvr\cats\TestRunner\Prod\Worker\Latest"
$scriptsSourceDir = "\\Csicesvr\cats\TestRunner\CATS Deployment Scripts"
$scriptsTargetDir = "C:\CATS_Prod\Scripts"
$softwareFolder = "$scriptsTargetDir\Software" 

$SQLServer = "tcp:catsdatabaseserver-dev.database.windows.net"
$SQLDB = "CATS"
$SQLUser = "apextest"
$SQLUserPassword = "KKKKkkkk1111!!!!"

$testUser = "redmond\apextest"
$testUserPWD = "Wacsc3373241..."

$runnerInstance1 = New-Object PSObject -property @{
    Name                = "Instance1"
    catsRunnerSourceDir = "\\Csicesvr\cats\TestRunner\Prod\Worker\Latest"
    SourcePath          = "C:\CATS_Prod\Worker1"
    FirewallName        = "CATSRunner1"
    FirewallPort        = 9000
    ScheduleTaskName    = "StartCATSInstance1"
}

$runnerInstance2 = New-Object PSObject -property @{
    Name                = "Instance2"
    catsRunnerSourceDir = "\\Csicesvr\cats\TestRunner\Prod\Worker9001\Latest"
    SourcePath          = "C:\CATS_Prod\Worker2"
    FirewallName        = "CATSRunner2"
    FirewallPort        = 9001
    ScheduleTaskName    = "StartCATSInstance2"
}

# $instances = ($runnerInstance1)
$instances = ($runnerInstance1, $runnerInstance2)

function Write-DateTimeMessage {
    param (
        [parameter(Mandatory = $false)] [switch]$Warning,
        [parameter(Mandatory = $true)]  [string]$Message,
        [parameter(Mandatory = $false)] [string]$ForegroundColor
    )
		
    if ($Warning) {
        Write-Warning ($(Get-Date -UFormat '%Y/%m/%d %H:%M:%S') + " * " + $Message)
    }
    else {
        if ($ForegroundColor) {
            Write-Host ($(Get-Date -UFormat '%Y/%m/%d %H:%M:%S') + " * " + $Message) -ForegroundColor $ForegroundColor
        }
        else {
            Write-Host ($(Get-Date -UFormat '%Y/%m/%d %H:%M:%S') + " * " + $Message)
        }
    }
	
}

function Write-Error0Message {
    Write-DateTimeMessage -Message $Error[0].Exception.Message -ForegroundColor Red
}
function Disable-InternetExplorerESC {
    $adminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $userKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $adminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $userKey -Name "IsInstalled" -Value 0
    Stop-Process -Name Explorer
    Write-DateTimeMessage -Message "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}

function Enable-InternetExplorerESC {
    $adminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $userKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $adminKey -Name "IsInstalled" -Value 1
    Set-ItemProperty -Path $userKey -Name "IsInstalled" -Value 1
    Stop-Process -Name Explorer
    Write-DateTimeMessage -Message "IE Enhanced Security Configuration (ESC) has been enabled." -ForegroundColor Green
}

function Create-FirewallRule {
    param (
        [Parameter(Mandatory = $true)]$name,
        [Parameter(Mandatory = $true)]$dir, 
        [Parameter(Mandatory = $false)]$localIP = "Any",
        [Parameter(Mandatory = $false)]$localport = "Any",
        [Parameter(Mandatory = $false)]$remoteIP = "Any",
        [Parameter(Mandatory = $false)]$remotePort = "Any",
        [Parameter(Mandatory = $false)]$pro = "Any",
        [Parameter(Mandatory = $false)]$protocol = "TCP",
        [Parameter(Mandatory = $false)]$action = "allow"
    )
    $exisitingRule = netsh advfirewall firewall show rule $name

    if ($exisitingRule -eq "No rules match the specified criteria.") {
        netsh advfirewall firewall add rule name=$name localip=$localIP localport=$localport remoteip=$remoteIP remoteport=$remotePort profile=$pro protocol=$protocol dir=$dir action=$action
    }
    else {
        netsh advfirewall firewall delete rule name=$Name
        netsh advfirewall firewall add rule name=$name localip=$localIP localport=$localport remoteip=$remoteIP remoteport=$remotePort profile=$pro protocol=$protocol dir=$dir action=$action
    }

    $exisitingRule = netsh advfirewall firewall show rule $name
    if ($exisitingRule -eq "No rules match the specified criteria.") {
        Write-DateTimeMessage -Warning "Fail to create firewall rule $name" -ForegroundColor Red
    }
    else {
        Write-DateTimeMessage -Message "Create firewall rule $name successfully" -ForegroundColor Green
    }
}

function Create-WindowsScheduleTask {
    param (
        [Parameter(Mandatory = $true)]$schTaskName,
        [Parameter(Mandatory = $true)]$path,
        [Parameter(Mandatory = $true)]$ru,
        [Parameter(Mandatory = $true)]$rp 
    )

    try {
        $Error.clear()
        $everyMinute = New-TimeSpan -Minutes 1
        $nolimit = New-TimeSpan -Minutes 0
    
        $action = New-ScheduledTaskAction -Execute $path
        $trigger = New-ScheduledTaskTrigger -AtStartup
        $settings = New-ScheduledTaskSettingsSet -RestartInterval $everyMinute -RestartCount 10 -Priority 0 -ExecutionTimeLimit $nolimit -StartWhenAvailable -DisallowHardTerminate

        Register-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -TaskName $schTaskName -User $ru -Password $rp -RunLevel Highest
    }
    Catch {
        Write-Error0Message
    }

    $existingSchtask = schtasks /query /tn $schTaskName
    if ($existingSchtask -eq $null) {
        Write-DateTimeMessage -Warning "Fail to create Windows Schedule Task $schTaskName" -ForegroundColor Red
    }
}

function Run-SQLSentence {
    param (
        [Parameter(Mandatory = $true)]$server,    
        [Parameter(Mandatory = $true)]$database,
        [Parameter(Mandatory = $true)]$userName,
        [Parameter(Mandatory = $true)]$password,
        [Parameter(Mandatory = $true)]$SQLSentence
    )
    try {
        $Error.clear()
        $connection = new-object System.Data.SqlClient.SQLConnection("Server=$server;Initial Catalog=$database;Persist Security Info=False;User ID=$userName;Password=$password;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        $cmd = new-object System.Data.SqlClient.SqlCommand($SQLSentence, $connection);

        $connection.Open()
        $cmd.ExecuteReader()

        $connection.Close()
    }
    catch {
        Write-Error0Message
    }
}

Function Install-Software {
    param (
        [Parameter(Mandatory = $true)]$path  
    )

    $name = $path.split("\")[-1] 

    Write-DateTimeMessage -Message "Starting to install $name"
    if ($name.contains("Chrome")) {
        $ExitCode = (Start-Process -filepath cmd.exe -argumentlist "/c $path /silent /install" -Verb RunAs -Wait -PassThru).ExitCode
    }
    elseif ($name.contains("jdk")) {
        $ExitCode = (Start-Process -filepath cmd.exe -argumentlist "/c $path /s INSTALL_SILENT=1 STATIC=0 AUTO_UPDATE=0 WEB_JAVA=1 WEB_JAVA_SECURITY_LEVEL=H WEB_ANALYTICS=0 EULA=0 REBOOT=0 NOSTARTMENU=0 SPONSORS=0" -Verb RunAs -Wait -PassThru).ExitCode
    }
    
    if ($ExitCode -eq 0) {
        Write-DateTimeMessage -Message "Install $name successfully!" -ForegroundColor Green
    }
    else {
        Write-DateTimeMessage -Warning "Failed to install $name. Exit code $ExitCode." -ForegroundColor Red
        exit
    }
}

try {
    $Error.clear()
    #Copy the Scripts
    Write-DateTimeMessage -Message "Starting Copying script files"
    Get-ChildItem -Path $scriptsSourceDir | Copy-Item -Destination $scriptsTargetDir -Recurse -Container -Force
    Write-DateTimeMessage -Message ("Copy source for {0} succefully" -f $instance.Name)

    #Install Software
    $softwares = Get-ChildItem $softwareFolder -Force 
    foreach ($software in $softwares) {
        Install-Software -path $software.FullName
    }

    foreach ($instance in $instances) {
        #Copy the CATS Runner
        Write-DateTimeMessage -Message ("Starting to copy source for {0}" -f $instance.Name)
        Get-ChildItem -Path $instance.catsRunnerSourceDir | Copy-Item -Destination $instance.SourcePath -Recurse -Container -Force
        Write-DateTimeMessage -Message ("Copy source for {0} succefully" -f $instance.Name)

        #Open the inbond Port
        Write-DateTimeMessage -Message ("Starting to create firewall rule for {0}" -f $instance.Name)
        Create-FirewallRule -name $instance.FirewallName -dir "in" -localport $instance.FirewallPort
        Write-DateTimeMessage -Message ("Create firewall rule for {0} succefully" -f $instance.Name)

        #Create Windows Task
        Write-DateTimeMessage -Message ("Starting to create Schedule tasks for {0}" -f $instance.Name)
        Create-WindowsScheduleTask -schTaskName $instance.ScheduleTaskName -path ($instance.SourcePath + "\TestRunner.Worker.exe") -ru $testUser -rp $testUserPWD
        Write-DateTimeMessage -Message ("Create Schedule tasks for {0} succefully" -f $instance.Name)

        #Starting the runner
        Write-DateTimeMessage -Message ("Trying to start Schedule tasks for {0}" -f $instance.Name)
        Start-ScheduledTask -TaskName $instance.ScheduleTaskName
        $runningStatus = Get-ScheduledTaskInfo -TaskName $instance.ScheduleTaskName
        if ($runningStatus.LastTaskResult -ne "267009") {
            Write-DateTimeMessage -Warning ("Fail to start Schedule tasks for {0}" -f $instance.Name)  -ForegroundColor Red
        }
        else {
            Write-DateTimeMessage -Warning ("Start Schedule tasks for {0} Succefully" -f $instance.Name) -ForegroundColor Green
        }
    }

    #Add the machine into DB
    Write-DateTimeMessage -Message ("Starting to Add runner into DB")
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
    $MachineID = Get-Date -Format "yyyyMMddHHmmss"
    $SQL = "Insert Into [dbo].[Machines] (MachineId, MachineName, TimeStamp, Status, MachinePool) values ('{0}', '{1}', '{2}', '0', '4')" -f $MachineID, $env:computername, $TimeStamp
    Run-SQLSentence -server $SQLServer -database $SQLDB -userName $SQLUser -password $SQLUserPassword -SQLSentence $SQL

    #Disable the internet Explorer ESC
    Disable-InternetExplorerESC
}
catch {
    Write-Error0Message
}