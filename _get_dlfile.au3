#include <Date.au3>


$dldir = @HomeDrive & @HomePath & "\Downloads"
$skey = "*.pdf"

$dlfilename = _get_dlfile($dldir, $skey)
If @error Then 
	ConsoleWrite("err no file is found" & @CRLF)
	Exit
EndIf 

ConsoleWrite("dlfilename=" & $dlfilename & @CRLF)



Func _get_dlfile($dldir, $skey) 
	Local $dltime = _NowCalc()
	$dltime = StringRegExpReplace($dltime, "[/: ]","")

	;ディレクトリ移動
	FileChangeDir($dldir)

	Local $dlfilename = ""
	Local $hsearch = 0
	Local $cnts = 0
	While 1 
		Sleep(5000)
		$hsearch = FileFindFirstFile($skey)
		If $hsearch=-1 Or @error Then 
		Else 
			;ファイルがあるようなので１つずつ見ていく
			While 1 
				$dlfilename = FileFindNextFile($hsearch)
				If @error Then 
					ExitLoop
				EndIf
				ConsoleWrite($dlfilename & @CRLF)
				Local $modtime = FileGetTime($dlfilename, $FT_MODIFIED, $FT_STRING)
				$modtime = Number($modtime)
				If $modtime >= $dltime Then 
					FileClose($hsearch)
					Return SetError(0,0,$dlfilename)
				EndIf
			WEnd
			FileClose($hsearch)
		EndIf

		$cnts += 5
		If $cnts >= 20 Then 
			ExitLoop ;;終了
		EndIf

	WEnd

	Return SetError(1,0,False)
EndFunc
