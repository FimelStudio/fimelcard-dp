function decrypto:player/audience
execute as @a[tag=dc.audience,scores={dc_team=1}] run tellraw @s {text:"[谍报风云] 你属于白队（合作队）。",color:"white"}
execute as @a[tag=dc.audience,scores={dc_team=2}] run tellraw @s {text:"[谍报风云] 你属于黑队（三人局为独立截密者）。",color:"light_purple"}
execute as @a[tag=dc.audience,scores={dc_role=0}] run tellraw @s {text:"本轮轮空，无需提交提示或密码。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=1}] run tellraw @s {text:"本轮身份：加密者。",color:"yellow"}
execute if score @s dc_mode matches 4 if score @s dc_round matches 2.. as @a[tag=dc.audience,scores={dc_role=1,dc_size=2}] run tellraw @s {text:"双方提示公开后，你还负责拦截。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=2}] run tellraw @s {text:"本轮身份：解密者。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=3}] run tellraw @s {text:"本轮身份：拦截者。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=4}] run tellraw @s {text:"本轮身份：解密者。",color:"yellow"}
