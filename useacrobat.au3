
Global $acroname = "Adobe Acrobat Reader DC"
Local $acroexe = "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
Local $basedir = @ScriptDir
Local $filename = "201910健康診断.pdf"

$ret = _print_pdf($acroexe, $basedir, $filename)

;---------
; PDFファイルを印刷する
;---------
Func _print_pdf($exepath, $basedir, $filename)
	Local $pid = Run($exepath & ' "' & $basedir & "\" & $filename & '"')
	If @error Then 
		Return SetError(1,0, "err: couldnt open pdf")
	EndIf

	;ウィンドウがアクティブになるのを待つ
	Local $hwn = WinWaitActive($filename,"",60)
	If $hwn = 0 Then 
		Return SetError(1,0, "err: window isnt active")
	EndIf
	Sleep(1000)

	; Alt + fp ショートカットでメニュー「ファイル->印刷」
	Send("!fp")
	$hwn = WinWaitActive("印刷","",60)
	If $hwn = 0 Then 
		ConsoleWrite("warning: print dialog isnt shown")
	Else
		Sleep(1000)

		; プリンタ選択(option)
		;Local $ret = _sel_printer("プリンタ名")

		; 印刷する AutoInfoで印刷ボタンコントロールクラスを取得した
		Local $ret = ControlClick("印刷", "", "[CLASS:Button; INSTANCE:50]")
		$hwn = WinWaitActive($filename, "", 60)

		; ここで印刷が終わるまで待ちたいがPDFファイルによってマチマチ
		Sleep(30000) ;30秒
	EndIf

	; PDFファイルを閉じる
	WinClose($filename)
	Sleep(3000)

	WinClose($acroname)

	Return SetError(0,0, "finish print pdf")
EndFunc
