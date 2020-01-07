#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y 
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI **** 

; 同じファイルを上書き保存したい場合は　Excel.au3を同じ階層にコピペして
; SaveAs()内のFileDelete()とその下の行をコメントアウトしinclude
#cs
; Excel.au3
;; L.307, L.308のFileDelete()をコメントアウト。
If FileExists($sFilePath) Then 
  If Not $bOverWrite Then Return SetError(3,0,0)
;  Local $iResult = FileDelete($sFilePath)  ;コメントアウトする
;  If $iResult = 0 Then Return SetError(4,0,0) ;コメントアウトする
EndIf
#ce
; #include "Excel.au3"
#include <Excel.au3>

Global $filepath = @ScriptDir & "\test.xlsx"
Global $filepath2 = @ScriptDir & "\test2.xlsx"  
;読み込み時パスワード 
Global $spass = "test1"  

Global $oexcel = 0 
Global $wbook = 0  

; エクセルハンドル取得 
$oexcel = _Excel_Open() 
If @error Then
	Consolewrite("-- error open" & @CRLF) 	
	Exit
EndIf  

;test.xlsxを開き、そのハンドルをwbookに 
$wbook = _Excel_BookOpen($oexcel, $filepath) 
If @error Then 
	ConsoleWrite("-- error bookopen err="& @error & @CRLF) 
	_Excel_Close($oexcel)
	Exit
EndIf  

;読み込み時パスワード設定し保存 
_Excel_BookSaveAs($wbook, $filepath2, $xlWorkbookDefault, True, $spass) 
If @error Then 	
	ConsoleWrite("-- error booksaveas err=" & @error & @CRLF) 
EndIf  

;終了 
_Excel_BookClose($oexcel, $wbook) 
_Excel_Close($oexcel)
