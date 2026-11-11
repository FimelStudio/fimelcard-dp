function decrypto:player/audience
tellraw @a[tag=dc.audience] {text:"════ 本轮公开分工 ════",color:"aqua",bold:true}
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.audience] {text:"红队",color:"red"}
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.audience] {text:"合作队",color:"green"}
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=0}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：轮空",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=1}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：加密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=2}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=3}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：拦截",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=4}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密",color:"gray"}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.audience] {text:"蓝队",color:"blue"}
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.audience] {text:"截密者",color:"red"}
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=0}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：轮空",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=1}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：加密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=2}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=3}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：拦截",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=4}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密",color:"gray"}]
execute if score @s dc_mode matches 4 if score @s dc_round matches 2.. if entity @a[tag=dc.audience,scores={dc_size=2}] run tellraw @a[tag=dc.audience] {text:"两人队的加密者也负责拦截。",color:"yellow"}
