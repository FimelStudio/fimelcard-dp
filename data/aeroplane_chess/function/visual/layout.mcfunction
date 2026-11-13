$data modify storage aeroplane_chess:visual layout set value "c$(cap)o$(orient)"
$data modify storage aeroplane_chess:visual footprint set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.footprint
$data modify storage aeroplane_chess:visual step set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.step
$data modify storage aeroplane_chess:visual scale set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.scale
$data modify storage aeroplane_chess:visual width set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.width
$data modify storage aeroplane_chess:visual board_y set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.board_y
$data modify storage aeroplane_chess:visual plane_y set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.plane_y
$data modify storage aeroplane_chess:visual die_scale set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.die_scale
$data modify storage aeroplane_chess:visual die_y set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.die_y
$data modify storage aeroplane_chess:visual qy set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.qy
$data modify storage aeroplane_chess:visual qw set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.qw
