$data modify storage aeroplane_chess:visual point set from storage aeroplane_chess:layout $(layout).p$(color)$(plane)[$(index)]
data modify storage aeroplane_chess:visual x set from storage aeroplane_chess:visual point.x
data modify storage aeroplane_chess:visual z set from storage aeroplane_chess:visual point.z
data modify storage aeroplane_chess:visual py set from storage aeroplane_chess:visual point.qy
data modify storage aeroplane_chess:visual pw set from storage aeroplane_chess:visual point.qw
