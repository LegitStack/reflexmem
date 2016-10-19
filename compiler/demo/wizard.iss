; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "ReflexMem Demo"
#define MyAppVersion "1.0"
#define MyAppPublisher "ReflexMem Industries LLC"
#define MyAppURL "http://www.reflexmem.com/"
#define MyAppExeName "reflexmem-demo.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{3E6DAD29-CBA5-4DB4-8B96-C721E3163DF7}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=C:\sites\reflexmem\license.txt
OutputDir=C:\sites\reflexmem\compiler\demo
OutputBaseFilename=ReflexMem-Demo_setup_1.0
SetupIconFile=C:\sites\reflexmem\ico\reflexmemicon64.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Dirs]
Name: "{userappdata}\ReflexMem\scripts\"
Name: "{userappdata}\ReflexMem\scripts\if\"
Name: "{userappdata}\ReflexMem\scripts\if\names\"
Name: "{userappdata}\ReflexMem\scripts\then\"
Name: "{userappdata}\ReflexMem\scripts\images\"
Name: "{userappdata}\ReflexMem\scripts\recipe\"
Name: "{userappdata}\ReflexMem\image\"
Name: "{userappdata}\ReflexMem\plugins\"
Name: "{app}\lib\"
Name: "{app}\lib\trig\"
Name: "{app}\lib\behave\"

[Files]
Source: "C:\sites\reflexmem\reflexmem-demo.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\sites\reflexmem\rmcreate-demo.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\sites\reflexmem\rmrun.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\executeif.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\executethen.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\filelocations.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\applieddpi.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\upgrademessage.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\keypress_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\wait_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\mouseclick_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\messagebox_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\managemousemove_behavior_demo"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


