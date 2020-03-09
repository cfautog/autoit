#AutoIt3Wrapper_UseX64=y
Global $g_sleep = 1000 ;クリック後スリープ

_clickfunc("left",1272,124,1)
_clickfunc("left",915,205,1)
_clickfunc("left",478,245,1)

Func _clickfunc($btn="left",$x=0,$y=0,$speed=10)
  MouseClick($btn,$x,$y,$speed)
  Sleep($g_sleep)
EndFunc
