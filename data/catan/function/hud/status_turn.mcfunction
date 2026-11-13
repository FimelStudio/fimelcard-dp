$data modify storage fimel_title:io text.extra set value [{"text":" · "},{"nbt":"data.catan.p$(turn).name","entity":"@e[tag=ca.current,limit=1]","interpret":true}]
$function catan:hud/name_color {side:$(turn),index:1}
