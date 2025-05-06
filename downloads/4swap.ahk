;============================================================================================;
;											     
; MACRO DOES NOT LIMIT FOR YOU								     					       	     
; ENTER YOUR OWN (X, Y) COORDINATES FOR THE LOADOUTS YOU WANT TO USE			     
; THIS AHK CREATES A TXT FILE IN THE SAME FILE LOCATION AS THE AHK TO SAVE YOUR COORDS	     
;											     
; @nettlimiter on discord								     
;											     
;============================================================================================;

#NoEnv 

#SingleInstance Force

Gui, +AlwaysOnTop
Gui, Font, s11 q5 000000, Whitney
Gui, Color, b0fbff

Gui Add, Hotkey, x85 y37 w75 h25 vSwapbind BackgroundTrans, %Swapbind%
Gui Add, Button, x85 y67 w75 h25 gUpdateHotkeys BackgroundTrans, Save

Gui, Font, s11 q5 000000 Bold
Gui Add, Text, x275 y14 w100 h25, desync
Gui, Font, s11 q5 000000
Gui Add, Edit, x340 y10 w50 h25 vCoord1X
Gui Add, Edit, x400 y10 w50 h25 vCoord1Y

Gui, Font, s11 q5 000000 Bold
Gui Add, Text, x277 y44 w100 h25, lorentz
Gui, Font, s11 q5 000000
Gui Add, Edit, x340 y40 w50 h25 vCoord2X
Gui Add, Edit, x400 y40 w50 h25 vCoord2Y

Gui, Font, s11 q5 000000 Bold
Gui Add, Text, x275 y74 w100 h25, desync
Gui, Font, s11 q5 000000
Gui Add, Edit, x340 y70 w50 h25 vCoord3X
Gui Add, Edit, x400 y70 w50 h25 vCoord3Y

Gui, Font, s11 q5 000000 Bold
Gui Add, Text, x277 y104 w100 h25, duality
Gui, Font, s11 q5 000000
Gui Add, Edit, x340 y100 w50 h25 vCoord4X
Gui Add, Edit, x400 y100 w50 h25 vCoord4Y

Gui, Show, w470 h140, 4 swappa

LoadData()

return

UpdateHotkeys:
	GuiControlGet, bind1,, SwapBind
	GuiControlGet, coord1x,, Coord1X
	GuiControlGet, coord1y,, Coord1Y
	GuiControlGet, coord2x,, Coord2X
	GuiControlGet, coord2y,, Coord2Y
	GuiControlGet, coord3x,, Coord3X
	GuiControlGet, coord3y,, Coord3Y
	GuiControlGet, coord4x,, Coord4X
	GuiControlGet, coord4y,, Coord4Y

	if (bind1){
		if(bind1 != SwapBind) {
			if(Swapbind){
				Hotkey, %SwapBind%, SwapHotkey, off
			}
			SwapBind := bind1  
			Hotkey, %SwapBind%, SwapHotkey, on
		}
	}

	
	SaveData(bind1, coord1x, coord1y, coord2x, coord2y, coord3x, coord3y, coord4x, coord4y)

return

SwapHotkey:
#If WinActive("Destiny 2")
SendMode Input
SetWorkingDir %A_ScriptDir%

Sleep, 100
Send {f1} 
Sleep, 100  
MouseMove, 515, 625

Loop, 25  
{
Sleep, 20  
Send, {Left}  
}
Sleep, 100 

Loop, 8  
{
MouseMove, %coord1x%, %coord1y% 
Sleep, 30 
Click  
Sleep, 30  
MouseMove, %coord2x%, %coord2y%  
Sleep, 30  
Click  
Sleep, 30
MouseMove, %coord3x%, %coord3y% 
Sleep, 30 
Click  
Sleep, 30 
MouseMove, %coord4x%, %coord4y%  
Sleep, 30  
Click  
Sleep, 30  
} 

Loop, 4  
{
MouseMove, %coord4x%, %coord4y%  
Sleep, 30
Click  
Sleep, 30
}

Sleep, 200
Send {f1}  
Sleep, 2000
	
return

F5::reload

GuiClose:
	ExitApp

SaveData(bind1, coord1x, coord1y, coord2x, coord2y, coord3x, coord3y, coord4x, coord4y) {
	filePath := A_ScriptDir "\data.txt"
	FileDelete, %filePath%
	FileAppend, %bind1%`n%coord1x%`n%coord1y%`n%coord2x%`n%coord2y%`n%coord3x%`n%coord3y%`n%coord4x%`n%coord4y%, %filePath%
}

LoadData() {
	filePath := A_ScriptDir "\data.txt"
	if FileExist(filePath) {
		FileRead, data, %filePath%
		StringSplit, dataArray, data, `n
		GuiControl,, SwapBind, %dataArray1%
		GuiControl,, Coord1X, %dataArray2%
		GuiControl,, Coord1Y, %dataArray3%
		GuiControl,, Coord2X, %dataArray4%
		GuiControl,, Coord2Y, %dataArray5%
		GuiControl,, Coord3X, %dataArray6%
		GuiControl,, Coord3Y, %dataArray7%
		GuiControl,, Coord4X, %dataArray8%
		GuiControl,, Coord4Y, %dataArray9%
	}
}

