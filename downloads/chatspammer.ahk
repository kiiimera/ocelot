#NoEnv 

#SingleInstance Force

; Menu, Tray, Icon, PASTE ICON PATH HERE

Gui, +AlwaysOnTop
Gui, Font, s11 q5 000000, Whitney
Gui, Color, f090e7

Gui Add, Hotkey, x20 y20 w75 h25 vchatbind BackgroundTrans, %chatbind%
Gui Add, Button, x20 y50 w75 h25 gUpdateHotkeys BackgroundTrans, Save

Gui Add, Edit, x110 y20 w200 h25 vnewSentence BackgroundTrans, 
Gui Add, Button, x110 y50 w150 h25 gSaveSentence BackgroundTrans, Save Sentence 
Gui Add, Button, x270 y50 w40 h25 gOpenTxt BackgroundTrans, txt 

Gui, Show, w330 h95, chat spammer
return

UpdateHotkeys:
	GuiControlGet, bind1,, chatBind

	if (bind1){
		if(bind1 != chatBind) {
			if(chatbind){
				Hotkey, %chatBind%, chatHotkey, off
			}
			chatBind := bind1  
			Hotkey, %chatBind%, chatHotkey, on
		}
	 }
return

SaveSentence:
	GuiControlGet, newSentence
	if (newSentence != "") {
		filePath := A_ScriptDir "\chatspammer.txt"
		FileAppend, %newSentence%`n, %filePath%
		MsgBox, sentence saved
		GuiControl,, newSentence, 
	} else {
		MsgBox, no sentence entered
	}
return

OpenTxt:
	filePath := A_ScriptDir "\chatspammer.txt"
	Run, %filePath%
return

chatHotkey:
#If WinActive("Destiny 2")
SendMode Input
SetWorkingDir %A_ScriptDir%

filePath := A_ScriptDir "\chatspammer.txt"
if (!FileExist(filePath)) {
	FileAppend, This is a sample sentence.`nAnother sample sentence.`nYet another sample sentence., %filePath%
}

FileRead, fileContent, %filePath%
StringSplit, lines, fileContent, `n
Random, randLine, 1, %lines0%
randomSentence := lines%randLine%

clipboard := randomSentence
ClipWait, 1

Send {Enter}
Sleep, 100
Send ^v
Sleep, 100
Send {Enter}

return

F5::reload

GuiClose:
	ExitApp
