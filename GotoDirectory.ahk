#SingleInstance, Force
Global ibTitle		:= "AHK Quick Folder"
Global ibWinTitle	:= ibTitle " ahk_exe AutoHotkey.exe"
Exit

ScrollLock::OpenFolder()
return

ScrollLockCloser(){
	; Make sure scroll lock is released
	KeyWait, ScrollLock
	; Wait 100ms for it to be pressed
	KeyWait, ScrollLock, D T0.1
	If (ErrorLevel = 0)
		; If pressed, close inputbox
		WinClose, % ibWinTitle
	return
}

OpenFolder(){
	folderA	:=	{ahk			:"C:\AHK"
				,jverner		:"T:\Evektor\UZIV\JVERNER"}
	
	found		:= 0
	folderName	:= ""
	
	; Start a timer that checks scroll lock
	SetTimer, ScrollLockCloser, 50
	; Get folder info
	InputBox, folderName, % ibTitle, Enter folder name:,, 250, 100, 550, 300, , , Downloads
	; Turn timer off
	SetTimer, ScrollLockCloser, Off
	; If cancel was pressed
	if (ErrorLevel > 0)
		; Notify user
		NotifyUser("Inputbox Canceled.")
	
	; Loop through folder array and see if folderName exists
	for index, value in folderA
		; If foldername matches index
		if (folderName = index)
		{
			; Set found to index 
			found := index
			; End the for loop
			break
		}
	
	; If the search didn't match anything
	if (found = 0)
		; Notify the user
		NotifyUser("No match found for " folderName ".")
	; If and index was found
	Else
		; Run the associated path
		Run, % folderA[found]
	
	return
}

NotifyUser(msg){
	; Nontify of what happened
	TrayTip, File Opener, % msg
	; Turn notification off in 3 sec
	SetTimer, NotifyOff, -3000
	; Exit the thread because there's nothing left to execute
	Exit
}

NotifyOff(){
	TrayTip
	return
}