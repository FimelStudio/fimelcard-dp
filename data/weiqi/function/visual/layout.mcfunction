$data modify storage weiqi:visual layout set value "s$(size)c$(cap)o$(orient)"
$data modify storage weiqi:visual step set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.step
$data modify storage weiqi:visual scale set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.scale
$data modify storage weiqi:visual width set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.width
$data modify storage weiqi:visual footprint set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.footprint
$data modify storage weiqi:visual board_y set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.board_y
$data modify storage weiqi:visual stone_y set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.stone_y
$data modify storage weiqi:visual frame_y set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.frame_y
$data modify storage weiqi:visual last_y set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.last_y
$data modify storage weiqi:visual qy set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.qy
$data modify storage weiqi:visual qw set from storage weiqi:layout s$(size)c$(cap)o$(orient).geom.qw
