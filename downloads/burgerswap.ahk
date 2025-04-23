;============================================================================================;
;											     ;
; THIS MACRO IS FOR 3074 & 27K IZI/VIGI SWAPPING 					     ;
; IT ALSO HAS BINDS FOR 3074 & 27K FIREWALL // DOES NOT REQUIRE LIMITER	                     ;
;											     ;
; SWAPS USE LOADOUTS 11 & 12								     ;
;											     ;
; @nettlimiter on discord								     ;
;											     ;
;============================================================================================;


#NoEnv 

#SingleInstance Force

; Global Variables

if (!A_IsAdmin){ 
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

; Defualt Binds (uncomment the bind you want permenantly bound)
; global 3074Bind := "F2"
; global 27kBind := "F3"
; global 27SwapBind := "F4"
; global 3074SwapBind := "F5"



; Hotkey, %3074bind%, 3074Hotkey
; Hotkey, %27Kbind%, 27kHotkey
; Hotkey, %27Swapbind%, 27SwapHotkey
; Hotkey, %3074Swapbind%, 3074SwapHotkey


mainGUI:

    Gui, +AlwaysOnTop
    Gui, Font, s11 q5 000000, Whitney
    Gui, Color, d2b173

    Gui Add, Text, x10 y10 w150 h25 +0x200 cbbf070, 3074:
    Gui Add, Hotkey, x250 y10 w75 h25 v3074bind, %3074bind%

    Gui Add, Text, x100 y10 w30 h25 +0x200 v3074Status, OFF

    Gui Add, Text, x10 y50 w150 h25 +0x200 ce7603c, 27k:
    Gui Add, Hotkey, x250 y50 w75 h25 v27Kbind, %27kbind%

    Gui Add, Text, x100 y50 w30 h25 +0x200 v27kStatus, OFF

    Gui Add, Text, x10 y90 w150 h25 +0x200 cf3e72b, 27Swap:
    Gui Add, Hotkey, x250 y90 w75 h25 v27Swapbind, %27Swapbind%

    Gui Add, Text, x10 y130 w150 h25 +0x200 c945836, 3074Swap:
    Gui Add, Hotkey, x250 y130 w75 h25 v3074Swapbind, %3074Swapbind%

    Gui Add, Button, x100 y190 w100 h20 gUpdateHotkeys, Save
    Gui, Show, w340 h225, burgerswap macro + limiter

return

3074Hotkey:
    if (toggle := !toggle) {
	guicontrol,, 3074Status, ON
	   enable3074()
	}
    else {
	guicontrol,, 3074Status, OFF
	   disable3074()
	}

return
   
27kHotkey:
    if (toggle := !toggle) {
        guicontrol,, 27kStatus, ON
	    enable27k()
	}
    else {
        guicontrol,, 27kStatus, OFF
	    disable27k()
	}

return

27SwapHotkey:
#If WinActive("Destiny 2")
SendMode Input
SetWorkingDir %A_ScriptDir%

 guicontrol,, 27kStatus, ON
	    enable27k()
	Sleep, 200
	Send {f1} 
	Sleep, 100  
	MouseMove, 515, 625
	
	Loop, 35  
	{
	Sleep, 35  
	Send, {Left}  
	}
	Sleep, 200 
	
	Loop, 30  
	{
	MouseMove, 143, 816  
	Sleep, 25 
	Click  
	Sleep, 25  
	MouseMove, 238, 816  
	Sleep, 25  
	Click  
	Sleep, 25  
	}
	
Send {f1}  
	Sleep, 1000  
	guicontrol,, 27kStatus, OFF
	    disable27k()

return

3074SwapHotkey:
#If WinActive("Destiny 2")
SendMode Input
SetWorkingDir %A_ScriptDir%

 guicontrol,, 3074Status, ON
	    enable3074()
	Sleep, 200
	Send {f1} 
	Sleep, 100  
	MouseMove, 515, 625
	
	Loop, 35  
	{
	Sleep, 35  
	Send, {Left}  
	}
	Sleep, 200 
	
	Loop, 20  
	{
	MouseMove, 143, 816  
	Sleep, 25 
	Click  
	Sleep, 25  
	MouseMove, 238, 816  
	Sleep, 25  
	Click  
	Sleep, 25  
	}
	
Send {f1}  
	Sleep, 1000  
	guicontrol,, 3074Status, OFF
	    disable3074()

return

;
;   HOTKEY SAVING AND UPDATING
;


UpdateHotkeys:
    GuiControlGet, bind1,, 3074Bind

    if (bind1){
        if(bind1 != 3074Bind) {
            if (3074Bind){
                Hotkey, %3074Bind%, 3074Hotkey, off
            }
            3074Bind := bind1  
            Hotkey, %3074Bind%, 3074Hotkey, on
        }
    }

    GuiControlGet, bind2,, 27kBind

    if (bind2){
        if(bind2 != 27kBind) {
            if (27kBind){
                Hotkey, %27kBind%, 27kHotkey, off
            }
            27kBind := bind2  
            Hotkey, %27kBind%, 27kHotkey, on
        }
    }
    
    GuiControlGet, bind3,, 27SwapBind

    if (bind3){
        if(bind3 != 27SwapBind) {
            if(27Swapbind){
                Hotkey, %27SwapBind%, 27SwapHotkey, off
            }
            27SwapBind := bind3  
            Hotkey, %27SwapBind%, 27SwapHotkey, on
        }
    }

    GuiControlGet, bind4,, 3074SwapBind

    if (bind4){
        if(bind4 != 3074SwapBind) {
            if(3074Swapbind){
                Hotkey, %3074SwapBind%, 3074SwapHotkey, off
            }
            3074SwapBind := bind4  
            Hotkey, %3074SwapBind%, 3074SwapHotkey, on
        }
    }

return

;
;       LIMITER
;

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

enable3074(){
    run netsh advfirewall firewall add rule dir=out action=block name="d2limit-3074-tcp-out" profile=any remoteport=3074 protocol=tcp interfacetype=any,,hide
    run netsh advfirewall firewall add rule dir=out action=block name="d2limit-3074-udp-out" profile=any remoteport=3074 protocol=udp interfacetype=any,,hide
    run netsh advfirewall firewall add rule dir=in action=block name="d2limit-3074-tcp-in" profile=any remoteport=3074 protocol=tcp interfacetype=any,,hide
    run netsh advfirewall firewall add rule dir=in action=block name="d2limit-3074-udp-in" profile=any remoteport=3074 protocol=udp interfacetype=any,,hide
}

disable3074(){
    run netsh advfirewall firewall delete rule name="d2limit-3074-tcp-out",,hide
    run netsh advfirewall firewall delete rule name="d2limit-3074-udp-out",,hide
    run netsh advfirewall firewall delete rule name="d2limit-3074-tcp-in",,hide
    run netsh advfirewall firewall delete rule name="d2limit-3074-udp-in",,hide
}

return
	

F5::reload

GuiClose:
    disable3074()
    disable27k()
    ExitApp