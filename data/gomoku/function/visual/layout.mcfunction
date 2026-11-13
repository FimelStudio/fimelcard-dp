$data modify storage gomoku:visual layout set value "s$(size)c$(cap)o$(orient)"
$data modify storage gomoku:visual step set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.step
$data modify storage gomoku:visual scale set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.scale
$data modify storage gomoku:visual width set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.width
$data modify storage gomoku:visual footprint set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.footprint
$data modify storage gomoku:visual board_y set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.board_y
$data modify storage gomoku:visual stone_y set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.stone_y
$data modify storage gomoku:visual frame_y set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.frame_y
$data modify storage gomoku:visual last_y set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.last_y
$data modify storage gomoku:visual qy set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.qy
$data modify storage gomoku:visual qw set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.qw
