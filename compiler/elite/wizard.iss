; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "ReflexMem Elite"
#define MyAppVersion "1.0"
#define MyAppPublisher "ReflexMem Industries LLC"
#define MyAppURL "http://www.reflexmem.com/"
#define MyAppExeName "reflexmem.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{D5CE5363-52CA-4EBA-B055-9EBCB8A03C53}
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
OutputDir=C:\sites\reflexmem\compiler\elite
OutputBaseFilename=ReflexMemSetup1.0
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
Name: "{userappdata}\ReflexMem\image\"
Name: "{userappdata}\ReflexMem\plugins\"
Name: "{app}\lib\"
Name: "{app}\lib\dll"
Name: "{app}\lib\trig\"
Name: "{app}\lib\behave\"
Name: "{app}\tesseract\"
Name: "{app}\tesseract\doc\"
Name: "{app}\tesseract\testing\"
Name: "{app}\tesseract\tessdata\"
Name: "{app}\tesseract\tesseract\configs\"
Name: "{app}\tesseract\tesseract\tessconfigs\"


[Files]
Source: "C:\sites\reflexmem\reflexmem.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\sites\reflexmem\rmcreate.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\sites\reflexmem\rmrun.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\alllcs.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion            
Source: "C:\sites\reflexmem\lib\executeif.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\executethen.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\levenshtein.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\applieddpi.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\filelocations.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\tesseract_stdout.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\combinealllcsandtesseract.au3"; DestDir: "{app}\lib\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\dll\ImageSearchDLL.dll"; DestDir: "{app}\lib\dll\"; Flags: ignoreversion

Source: "C:\sites\reflexmem\lib\trig\clipboard_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\dateto_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\do_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\imageonscreen_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\keypress_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\managetextonscreen_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\managevarequals_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\markrect_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\mouseat_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\mouseclick_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\trig\programruns_trigger"; DestDir: "{app}\lib\trig\"; Flags: ignoreversion

Source: "C:\sites\reflexmem\lib\behave\clipboard_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\keydown_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\keyup_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\managedisplay_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\managekeypress_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\managemousemove_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\manageprograms_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\managereflexmem_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\managevariable_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\messagebox_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\mouseclick_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\sendkeys_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\textonscreen_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\tooltip_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\userinteraction_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\volume_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\lib\behave\wait_behavior"; DestDir: "{app}\lib\behave\"; Flags: ignoreversion

Source: "C:\sites\reflexmem\tesseract\*"; DestDir: "{app}\tesseract\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\tesseract\doc\*"; DestDir: "{app}\tesseract\doc\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\tesseract\tessdata\*"; DestDir: "{app}\tesseract\tessdata\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\tesseract\testing\*"; DestDir: "{app}\tesseract\testing\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\tesseract\tessdata\configs\*"; DestDir: "{app}\tesseract\configs\"; Flags: ignoreversion
Source: "C:\sites\reflexmem\tesseract\tessdata\tessconfigs\*"; DestDir: "{app}\tesseract\tessconfigs\"; Flags: ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


