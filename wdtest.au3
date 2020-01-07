;
; WebDriver 経由でChromeを立ち上げるサンプル
; ダウンロードしたUDFはincludeフォルダに入れておく
; wd_core.au3,Json.au3,WinHttp.au3
; chromedriverはc:\wd\に入れておく。インストールされているchromeのバージョンに合ったchromedriverを入れること
;
#include <wd_core.au3>

; まずクロームの設定を記述
_WD_Option('Driver', 'C:\wd\chromedriver.exe') ;webdriverを指定
_WD_Option('DriverParams', ' --verbose --log-path=' & @ScriptDir & '\wdlog.log')
_WD_Option('Port', 9515)
$sdesire = '{"capabilities": {"alwaysMatch":{"goog:chromeOptions":{"w3c": true, "args":["--disable-gpu-early-init,"]}}}}'

;start　黒い画面(Chrome WebDriver)が立ち上がる
Local $pid = _WD_Startup()
If @error Then
  Msgbox(4096,"error", "webdriverの起動に失敗しました")
  Exit
EndIf

;セッションを追加　ChromeDriver経由でChrome新ウィンドウが立ち上がる
$sess = _WD_CreateSession($sdesire)
If @error Then
  MsgBox(4096, "error", "ブラウザ立ち上がりませんでした")
  Exit
EndIf

;このサイトを表示する
Sleep(1000)
_WD_Navigate($sess, "https://cfautog.tokyo")
If @error Then
  MsgBox(4096, "error", "指定したUrlを開けませんでした。 extended=" & @extended )
EndIf
Sleep(3000)

;chromeを閉じる
_WD_Window($sess, "close")
_WD_DeleteSession($sess)

;webdriverを終了
_WD_Shutdown()
