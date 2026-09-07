scoreboard players operation #ctx dc_ctx = @s dc_id
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=1}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你属于白队，本轮身份为加密者。',color:'white'}]
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你属于白队，本轮身份为解密者。',color:'white'}]
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=2,dc_encoder=1}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你属于黑队，本轮身份为加密者。',color:'light_purple'}]
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=2,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你属于黑队，本轮身份为解密者。',color:'light_purple'}]
execute if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=1}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你属于合作队，本轮身份为加密者。',color:'green'}]
execute if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你属于合作队，本轮身份为解密者。',color:'green'}]
execute if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=2}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你是截密者。',color:'red',bold:true}]
