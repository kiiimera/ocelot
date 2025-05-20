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
global WindowWidth := 260
global LabelCount := Ceil(WindowWidth / LabelWidth) + 2
global ScrollColor := "FFFFFF"

Gui, +AlwaysOnTop
Gui, Font, s11 q5 000000, Whitney
Gui, Color, 000000

Gui, Add, Hotkey, x10 y10 w75 h25 vEvilbind BackgroundTrans, %EvilBind%
Gui, Add, Button, x90 y10 w100 h25 gUpdateHotkeys BackgroundTrans, save hotkey

Gui, Add, Edit, x10 y45 w135 h25 vMsgInput,
Gui, Add, Button, x150 y45 w100 h25 gSaveMessage, save message

Loop, %LabelCount%
{
    idx := A_Index
    Gui, Add, Text, x0 y80 w%LabelWidth% h20 vInstText%idx% BackgroundTrans,
}

SetTimer, AnimateInstruction, 30
Gui, Show, w%WindowWidth% h105, game crasher
return

AnimateInstruction:
    ScrollX -= 1
    if (ScrollX <= -LabelWidth)
        ScrollX := 0

    Loop, %LabelCount%
    {
        idx := A_Index
        xPos := ScrollX + (idx - 1) * LabelWidth

        GuiControl,, InstText%idx%, instructions in code
        GuiControl, +c%ScrollColor%, InstText%idx%
        GuiControl, Move, InstText%idx%, x%xPos% y80
    }
return

EvilHotkey:
#If WinActive("Destiny 2")
SendMode Input
SetWorkingDir %A_ScriptDir%

enable27k()
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

disable27k()
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
