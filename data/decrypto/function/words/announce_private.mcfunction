scoreboard players operation #ctx dc_ctx = @s dc_id
function decrypto:hud/load_keywords
execute as @a[tag=dc.player,scores={dc_team=1}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[本局己方词条] ',color:'white',bold:true},{nbt:'white',storage:'decrypto:hud',interpret:true,color:'aqua'}]
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=2}] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[本局己方词条] ',color:'white',bold:true},{nbt:'black',storage:'decrypto:hud',interpret:true,color:'light_purple'}]
