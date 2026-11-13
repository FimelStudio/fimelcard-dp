data modify storage avalon:map portrait set value {object:"player",player:{},hat:true,color:"white"}
data modify storage avalon:map portrait.player.id set from entity @s UUID
execute if data storage avalon:map portraits[0] run data modify storage avalon:map portraits append value {text:" "}
data modify storage avalon:map portraits append from storage avalon:map portrait
