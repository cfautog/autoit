#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****


;; パスは適宜変更してください
#include "Includes\UIA_Constants.au3" ; Can be copied from UIASpy Includes folder

Opt( "MustDeclareVars", 1 )

Example()

Func Example()
  ;; メモ帳開く
  Run("notepad")
  Sleep(1000)

  ; UIAutomation オブジェクト生成
  Local $oUIAutomation = ObjCreateInterface( $sCLSID_CUIAutomation8, $sIID_IUIAutomation6, $dtag_IUIAutomation6 )
  If Not IsObj( $oUIAutomation ) Then Return ConsoleWrite( "$oUIAutomation ERR" & @CRLF )
  ConsoleWrite( "$oUIAutomation OK" & @CRLF )

  ; デスクトップ　取得
  Local $pDesktop, $oDesktop
  $oUIAutomation.GetRootElement( $pDesktop )
  $oDesktop = ObjCreateInterface( $pDesktop, $sIID_IUIAutomationElement9, $dtag_IUIAutomationElement9 )
  If Not IsObj( $oDesktop ) Then Return ConsoleWrite( "$oDesktop ERR" & @CRLF )
  ConsoleWrite( "$oDesktop OK" & @CRLF )


  ; メモ帳オブジェクト取得
  ConsoleWrite( "--- Find Notepad ---" & @CRLF )

  Local $pCondition
  $oUIAutomation.CreatePropertyCondition( $UIA_ClassNamePropertyId, "Notepad", $pCondition )
  If Not $pCondition Then Return ConsoleWrite( "$pCondition ERR" & @CRLF )
  ConsoleWrite( "$pCondition OK" & @CRLF )

  Local $pNotepad, $oNotepad
  $oDesktop.FindFirst( $TreeScope_Children, $pCondition, $pNotepad )
  $oNotepad = ObjCreateInterface( $pNotepad, $sIID_IUIAutomationElement9, $dtag_IUIAutomationElement9 )
  If Not IsObj( $oNotepad ) Then Return ConsoleWrite( "$oNotepad ERR" & @CRLF )
  ConsoleWrite( "$oNotepad OK" & @CRLF )


  ; --- メモ帳のエディターコントロール取得
  ConsoleWrite( "--- Find edit control ---" & @CRLF )

  $oUIAutomation.CreatePropertyCondition( $UIA_AutomationIdPropertyId, "15", $pCondition )
  If Not $pCondition Then Return ConsoleWrite( "$pCondition ERR" & @CRLF )
  ConsoleWrite( "$pCondition OK" & @CRLF )

  Local $pEdit, $oEdit
  $oNotepad.FindFirst( $TreeScope_Descendants, $pCondition, $pEdit )
  $oEdit = ObjCreateInterface( $pEdit, $sIID_IUIAutomationElement9, $dtag_IUIAutomationElement9 )
  If Not IsObj( $oEdit ) Then Return ConsoleWrite( "$oEdit ERR" & @CRLF )
  ConsoleWrite( "$oEdit OK" & @CRLF )


  ; --- 文字書き込み ---
  ConsoleWrite( "--- LegacyIAccessible Pattern (action) Object ---" & @CRLF )

  Local $pVal, $oVal
  $oEdit.GetCurrentPattern( $UIA_LegacyIAccessiblePatternId, $pVal )
  $oVal = ObjCreateInterface( $pVal, $sIID_IUIAutomationLegacyIAccessiblePattern, $dtag_IUIAutomationLegacyIAccessiblePattern )
  If Not IsObj( $oVal ) Then Return ConsoleWrite( "$oVal ERR" & @CRLF )
  ConsoleWrite( "$oVal OK" & @CRLF )

  $oVal.SetValue("ハローワールド\n")
  Sleep(100)



  ;;----------------
  ;; メニュー操作
  ;;----------------

  ; --- Find window/control ---

  ConsoleWrite( "--- Find window/control ---" & @CRLF )

  Local $pCondition1
  $oUIAutomation.CreatePropertyCondition( $UIA_NamePropertyId, "ファイル(F)", $pCondition1 )
  If Not $pCondition1 Then Return ConsoleWrite( "$pCondition1 ERR" & @CRLF )
  ConsoleWrite( "$pCondition1 OK" & @CRLF )

  Local $pMenuFile, $oMenuFile
  $oNotepad.FindFirst( $TreeScope_Descendants, $pCondition1, $pMenuFile )
  $oMenuFile = ObjCreateInterface( $pMenuFile, $sIID_IUIAutomationElement9, $dtag_IUIAutomationElement9 )
  If Not IsObj( $oMenuFile ) Then Return ConsoleWrite( "$oMenuFile ERR" & @CRLF )
  ConsoleWrite( "$oMenuFile OK" & @CRLF )

  ; --- Invoke Pattern (action) メニュー「ファイル」クリック ---
  ConsoleWrite( "--- Invoke Pattern (action) Object ---" & @CRLF )

  Local $pInvokeFile, $oInvokeFile
  $oMenuFile.GetCurrentPattern( $UIA_InvokePatternId, $pInvokeFile )
  $oInvokeFile = ObjCreateInterface( $pInvokeFile, $sIID_IUIAutomationInvokePattern, $dtag_IUIAutomationInvokePattern )
  If Not IsObj( $oInvokeFile ) Then Return ConsoleWrite( "$oInvokeFile ERR" & @CRLF )
  ConsoleWrite( "$oInvokeFile OK" & @CRLF )

  $oInvokeFile.Invoke()
  Sleep(1000)




  ; --- Find 名前をつけて保存をクリック ---
  ConsoleWrite( "--- Find window/control ---" & @CRLF )

  ;Local $pCondition0
  $oUIAutomation.CreatePropertyCondition( $UIA_AutomationIdPropertyId, "4", $pCondition1 )
  If Not $pCondition1 Then Return ConsoleWrite( "$pCondition1 ERR" & @CRLF )
  ConsoleWrite( "$pCondition1 OK" & @CRLF )

  Local $pMenuSaveAs, $oMenuSaveAs
  $oNotepad.FindFirst( $TreeScope_Descendants, $pCondition1, $pMenuSaveAs )
  $oMenuSaveAs = ObjCreateInterface( $pMenuSaveAs, $sIID_IUIAutomationElement9, $dtag_IUIAutomationElement9 )
  If Not IsObj( $oMenuSaveAs ) Then Return ConsoleWrite( "$oMenuSaveAs ERR" & @CRLF )
  ConsoleWrite( "$oMenuSaveAs OK" & @CRLF )


  Local $pInvokeSaveAs, $oInvokeSaveAs
  $oMenuSaveAs.GetCurrentPattern( $UIA_InvokePatternId, $pInvokeSaveAs )
  $oInvokeSaveAs = ObjCreateInterface( $pInvokeSaveAs, $sIID_IUIAutomationInvokePattern, $dtag_IUIAutomationInvokePattern )
  If Not IsObj( $oInvokeSaveAs ) Then Return ConsoleWrite( "$oInvokeSaveAs ERR" & @CRLF )
  ConsoleWrite( "$oInvokeSaveAs OK" & @CRLF )

  $oInvokeSaveAs.Invoke()
  Sleep(1000)



  ;;--------------
  ;; 保存ダイアログ
  ;;--------------
  ConsoleWrite( "--- save dialog --- " & @CRLF)

  $oUIAutomation.CreatePropertyCondition( $UIA_ClassNamePropertyId, "#32770", $pCondition )
  If Not $pCondition Then Return ConsoleWrite( "$pCondition ERR" & @CRLF )
  ConsoleWrite( "$pCondition OK" & @CRLF )


  Local $pSaveDialog, $oSaveDialog
  $oNotepad.FindFirst( $TreeScope_Descendants, $pCondition, $pSaveDialog )
  $oSaveDialog = ObjCreateInterface( $pSaveDialog, $sIID_IUIAutomationElement, $dtag_IUIAutomationElement )
  If Not IsObj( $oSaveDialog ) Then Return ConsoleWrite( "$oSaveDialog err" & @CRLF )
  ConsoleWrite( "$oSaveDialog OK" & @CRLF )


  ; --- Find window/control ---
  ConsoleWrite( "--- save " & @CRLF )

  $oUIAutomation.CreatePropertyCondition( $UIA_AutomationIdPropertyId, "1001", $pCondition)
  If Not $pCondition Then Return ConsoleWrite( "$pCondition err" & @CRLF)
  ConsoleWrite( "$pCondition OK" & @CRLF )

  $oSaveDialog.FindFirst( $TreeScope_Descendants, $pCondition, $pEdit)
  $oEdit = ObjCreateInterface( $pEdit, $sIID_IUIAutomationElement, $dtag_IUIAutomationElement )
  If Not IsObj( $oEdit ) Then Return ConsoleWrite( "$oEdit err" & @CRLF )
  ConsoleWrite( "$oEdit OK" & @CRLF)

  $oEdit.GetCurrentPattern( $UIA_LegacyIAccessiblePatternId, $pVal )
  $oVal = ObjCreateInterface( $pVal, $sIID_IUIAutomationLegacyIAccessiblePattern, $dtag_IUIAutomationLegacyIAccessiblePattern )
  If Not IsObj( $oVal ) Then Return ConsoleWrite( "$oVal ERR" & @CRLF )
  ConsoleWrite( "$oVal OK" & @CRLF )

  $oVal.SetValue("C:\Users\koyama\Downloads\はろーわーるど.txt")
  Sleep(100)


  Local $pCondition8, $pCondition9, $pAndCondition9
  $oUIAutomation.CreatePropertyCondition( $UIA_AutomationIdPropertyId, "1", $pCondition8 )
  $oUIAutomation.CreatePropertyCondition( $UIA_ControlTypePropertyId, $UIA_ButtonControlTypeId, $pCondition9 )
  $oUIAutomation.CreateAndCondition( $pCondition8, $pCondition9, $pAndCondition9 )
  If Not $pAndCondition9 Then Return ConsoleWrite( "$pAndCondition9 ERR" & @CRLF )
  ConsoleWrite( "$pAndCondition9 OK" & @CRLF )

  Local $pButton, $oButton
  $oSaveDialog.FindFirst( $TreeScope_Descendants, $pAndCondition9, $pButton )
  $oButton = ObjCreateInterface( $pButton, $sIID_IUIAutomationElement, $dtag_IUIAutomationElement )
  If Not IsObj( $oButton ) Then Return ConsoleWrite( "$oButton ERR" & @CRLF )
  ConsoleWrite( "$oButton OK" & @CRLF )


  $oButton.GetCurrentPattern( $UIA_InvokePatternId, $pInvokeFile )
  $oInvokeFile = ObjCreateInterface( $pInvokeFile, $sIID_IUIAutomationInvokePattern, $dtag_IUIAutomationInvokePattern )
  If Not IsObj( $oInvokeFile ) Then Return ConsoleWrite( "$oInvokeFile ERR" & @CRLF )
  ConsoleWrite( "$oInvokeFile OK" & @CRLF )

  $oInvokeFile.Invoke()

EndFunc
