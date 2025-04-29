;============================================================================================;
;											     ;
; MACRO LIMITS FOR YOU								             ;					       	     
; IN EMOTES, FAVOURITE A 2 PLAYER EMOTE SO IT IS IN THE FIRST EMOTE SLOT		     ;
; EQUIP A 3 PLAYER EMOTE IN THE LEFT SLOT BEFORE RUNNING MACRO				     ;
;											     ;
; @nettlimiter on discord								     ;
;											     ;
;============================================================================================;

#NoEnv 

#SingleInstance Force

if (!A_IsAdmin){ 
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

Gui, +AlwaysOnTop
Gui, Font, s11 q5 000000, Whitney
Gui, Color, 000000

Gui Add, Hotkey, x142 y65 w75 h25 vEvilbind BackgroundTrans, %EvilBindbind%
Gui Add, Button, x142 y95 w75 h25 gUpdateHotkeys BackgroundTrans, Save

Gui, Show, w350 h200, game gone 

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
    Sleep,600
    click right

    Sleep, 500
    MouseMove, 280, 380
    
    Sleep, 50
    Loop, 3
    {
    Sleep, 25
    Click
    }

    Sleep, 300
    MouseMove, 1230, 580
	
    Sleep, 50
	Loop, 3  
	{
	Sleep, 25  
	Click  
	}
	Sleep, 300 
	
Send {f1}  
	Sleep, 1000  
	    disable27k()

return

;   HOTKEY SAVING AND UPDATING

UpdateHotkeys:
    
    GuiControlGet, bind1,, EvilBind

    if (bind1){
        if(bind1 != EvilBind) {
            if(Evilbind){
                Hotkey, %EvilBind%, EvilHotkey, off
            }
            EvilBind := bind1  
            Hotkey, %EvilBind%, EvilHotkey, on
        }
    }

return

;       LIMITER

enable27k(){ 
    run netsh advfirewall firewall add rule dir=out action=block name="d2limit-27k-tcp-out" profile=any remoteport=27015-27200 protocol=tcp interfacetype=any,,hide
    run netsh advfirewall firewall add rule dir=out action=block name="d2limit-27k-udp-out" profile=any remoteport=27015-27200 protocol=udp interfacetype=any,,hide
    run netsh advfirewall firewall add rule dir=in action=block name="d2limit-27k-tcp-in" profile=any remoteport=27015-27200 protocol=tcp interfacetype=any,,hide
    run netsh advfirewall firewall add rule dir=in action=block name="d2limit-27k-udp-in" profile=any remoteport=27015-27200 protocol=udp interfacetype=any,,hide
}

disable27k(){
    run netsh advfirewall firewall delete rule name="d2limit-27k-tcp-out",,hide
    run netsh advfirewall firewall delete rule name="d2limit-27k-udp-out",,hide
    run netsh advfirewall firewall delete rule name="d2limit-27k-tcp-in",,hide
    run netsh advfirewall firewall delete rule name="d2limit-27k-udp-in",,hide
}

return

GuiClose:
    disable27k()
    ExitApp