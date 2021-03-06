#include <File.au3>

;==============================================================================================================
; https://stackoverflow.com/questions/3918747/send-an-email-with-autoit
; Description :  Send an email with a SMTP server by Microsoft CDO technology
; Parametere  : $s_SmtpServer
;               $s_FromName
;               $s_FromAddress
;               $s_ToAddress
;               $s_Subject
;               $as_Body
;               $s_AttachFiles (path file to join)
;               $s_CcAddress
;               $s_BccAddress
;               $s_Username
;               $s_Password
;               $IPPort
;               $ssl
; Return      :  On success none
;                On error code+msg
;==============================================================================================================
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", _
 $s_CcAddress = "", $s_BccAddress = "", $s_Username = "", $s_Password = "",$IPPort=25, $ssl=1)

    Local $objEmail = ObjCreate("CDO.Message")
    Local $i_Error = 0
    Local $i_Error_desciption = ""

    $objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
    $objEmail.To = $s_ToAddress

    If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
    If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress

    $objEmail.Subject = $s_Subject

    If StringInStr($as_Body,"<") and StringInStr($as_Body,">") Then
        $objEmail.HTMLBody = $as_Body
    Else
        $objEmail.Textbody = $as_Body & @CRLF
    EndIf

    If $s_AttachFiles <> "" Then
        Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
        For $x = 1 To $S_Files2Attach[0]
            $S_Files2Attach[$x] = _PathFull ($S_Files2Attach[$x])
            If FileExists($S_Files2Attach[$x]) Then
                $objEmail.AddAttachment ($S_Files2Attach[$x])
            Else
                $i_Error_desciption = $i_Error_desciption & @lf & 'File not found to attach: ' & $S_Files2Attach[$x]
                SetError(1)
                return 0
            EndIf
        Next
    EndIf
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort

    ;Authenticated SMTP
    If $s_Username <> "" Then
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
    EndIf
    If $Ssl Then
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
    EndIf

    ;Update settings
    $objEmail.Configuration.Fields.Update

    ; Sent the Message
    $objEmail.Send
    if @error then
        SetError(2)
;        return $oMyRet[1]
    	return "failed to send a message"
    EndIf
EndFunc ;==>_INetSmtpMailCom
