;============================================================================================;
;											     
; MACRO LIMITS 27K FOR YOU	
;							             					       	     
; IN EMOTES, FAVOURITE A 2 PLAYER EMOTE SO IT IS IN THE FIRST EMOTE SLOT 		     
; EQUIP AND USE 3 PLAYER EMOTE IN THE LEFT SLOT AND USE ON/NEAR TARGET PLAYER BEFORE RUNNING MACRO	
;
; SAVE MESSAGE TO SAY GOODBYE BEFORE GAME GONE
;
; CONFIGURED FOR 1920 x 1080 ONLY			     
;											     
; @nettlimiter on discord								     
;											     
;============================================================================================;

#NoEnv
#SingleInstance Force
if (!A_IsAdmin) {
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

global ScrollX := 0
global LabelWidth := 120 
global WindowWidth := 290
global WindowHeight := 70
global LabelCount := Ceil(WindowWidth / LabelWidth) + 2
global ScrollColor := "FFFFFF"
global Margin := 6
global ControlHeight := 23  ; Standardized height for all controls

Gui, +AlwaysOnTop
Gui, Font, s9 q5 000000, Whitney
Gui, Color, 000000

; Calculate control widths for custom spacing
ControlWidth := WindowWidth - (Margin * 2)

; Calculate save button width first as our alignment point
SaveButtonWidth := ControlWidth * 0.2      ; 20% for both save buttons

; First row widths
DropDownWidth := ControlWidth * 0.5  ; 50% for dropdown
HotkeyWidth := ControlWidth - DropDownWidth - SaveButtonWidth - (2 * Margin)  ; Remaining space for hotkey

; Second row widths - adjusted to give more space to save message button
SaveMsgButtonWidth := ControlWidth * 0.3   ; 30% for save message button to fit text
MessageWidth := ControlWidth - SaveMsgButtonWidth - Margin  ; Message takes remaining space

; Center controls vertically
VerticalCenter := (WindowHeight - (ControlHeight * 2)) / 3

; First row - Combined Mode selection, Hotkey and Save button
FirstRowY := VerticalCenter
FirstX := Margin
Gui, Add, DropDownList, x%FirstX% y%FirstRowY% w%DropDownWidth% h%ControlHeight% R2 vLimitMode Choose1 gModeSelect, use with 27k|use without 27k
HotkeyX := FirstX + DropDownWidth + Margin
Gui, Add, Hotkey, x%HotkeyX% y%FirstRowY% w%HotkeyWidth% h%ControlHeight% vEvilbind BackgroundTrans, %EvilBind%
SaveX := HotkeyX + HotkeyWidth + Margin
Gui, Add, Button, x%SaveX% y%FirstRowY% w%SaveButtonWidth% h%ControlHeight% gUpdateHotkeys BackgroundTrans, Save

; Second row - Message input and Save button
SecondRowY := FirstRowY + ControlHeight + VerticalCenter
Gui, Add, Edit, x%Margin% y%SecondRowY% w%MessageWidth% h%ControlHeight% vMsgInput,
SaveMsgX := Margin + MessageWidth + Margin
Gui, Add, Button, x%SaveMsgX% y%SecondRowY% w%SaveMsgButtonWidth% h%ControlHeight% gSaveMessage BackgroundTrans, Save Message

Gui, Show, w%WindowWidth% h%WindowHeight%, Game Crasher
return

EvilHotkey:
#If WinActive("Destiny 2")
SendMode Input
SetWorkingDir %A_ScriptDir%

GuiControlGet, LimitMode
if (LimitMode = "use with 27k") {
    enable27k()
}

Sleep, 200
Send {f1}
Sleep, 750
Send {S}
Sleep, 200
MouseMove, 1400, 640
Sleep, 600
Click Right
Sleep, 500
MouseMove, 280, 380
Sleep, 50
Loop, 3 {
    Sleep, 25
    Click
}

Send {Enter}
Sleep, 100
Send ^v
Sleep, 100
Send {Enter}
Sleep, 300

MouseMove, 1230, 580
Sleep, 50
Loop, 4 {
    Sleep, 25
    Click
}
Sleep, 300
Send {f1}
Sleep, 1000

if (LimitMode = "use with 27k") {
    disable27k()
}
return

UpdateHotkeys:
GuiControlGet, bind1,, Evilbind
if (bind1) {
    if (bind1 != EvilBind) {
        if (EvilBind) {
            Hotkey, %EvilBind%, EvilHotkey, off
        }
        EvilBind := bind1
        Hotkey, %EvilBind%, EvilHotkey, on
    }
}
return

SaveMessage:
GuiControlGet, MsgInput
if (MsgInput != "") {
    FileDelete, msg.txt
    FileAppend, %MsgInput%, msg.txt
    Clipboard := MsgInput
    Gui +OwnDialogs
    MsgBox, 64, Saved, message saved 
}
return


enable27k() {
    Run, %ComSpec% /c netsh advfirewall firewall add rule dir=out action=block name="d2limit-27k-tcp-out" profile=any remoteport=27015-27200 protocol=tcp interfacetype=any,,hide
    Run, %ComSpec% /c netsh advfirewall firewall add rule dir=out action=block name="d2limit-27k-udp-out" profile=any remoteport=27015-27200 protocol=udp interfacetype=any,,hide
    Run, %ComSpec% /c netsh advfirewall firewall add rule dir=in action=block name="d2limit-27k-tcp-in" profile=any remoteport=27015-27200 protocol=tcp interfacetype=any,,hide
    Run, %ComSpec% /c netsh advfirewall firewall add rule dir=in action=block name="d2limit-27k-udp-in" profile=any remoteport=27015-27200 protocol=udp interfacetype=any,,hide
}

disable27k() {
    Run, %ComSpec% /c netsh advfirewall firewall delete rule name="d2limit-27k-tcp-out",,hide
    Run, %ComSpec% /c netsh advfirewall firewall delete rule name="d2limit-27k-udp-out",,hide
    Run, %ComSpec% /c netsh advfirewall firewall delete rule name="d2limit-27k-tcp-in",,hide
    Run, %ComSpec% /c netsh advfirewall firewall delete rule name="d2limit-27k-udp-in",,hide
}

GuiClose:
disable27k()
ExitApp

ModeSelect:
GuiControlGet, LimitMode
return
