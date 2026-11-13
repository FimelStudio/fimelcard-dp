data modify storage catan:hud colored_name set value {text:"",color:"white",extra:[]}
$data modify storage catan:hud colored_name.extra append from entity @e[tag=ca.current,limit=1] data.catan.p$(side).name
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:1} run data modify storage catan:hud colored_name.color set value "#b94b43"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:1} run data modify storage catan:hud colored_name.extra[0].color set value "#b94b43"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:2} run data modify storage catan:hud colored_name.color set value "#3b80b4"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:2} run data modify storage catan:hud colored_name.extra[0].color set value "#3b80b4"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:3} run data modify storage catan:hud colored_name.color set value "#e3d9ba"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:3} run data modify storage catan:hud colored_name.extra[0].color set value "#e3d9ba"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:4} run data modify storage catan:hud colored_name.color set value "#da883a"
$execute if data entity @e[tag=ca.current,limit=1] data.catan.p$(side){color:4} run data modify storage catan:hud colored_name.extra[0].color set value "#da883a"
$data modify storage fimel_title:io text.extra[$(index)] set from storage catan:hud colored_name
