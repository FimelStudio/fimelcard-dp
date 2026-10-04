function decrypto:player/audience
execute as @a[tag=dc.audience,scores={dc_team=1}] run tellraw @s {text:"[谍报风云] 你属于白队（合作队）。",color:"white"}
execute as @a[tag=dc.audience,scores={dc_team=2}] run tellraw @s {text:"[谍报风云] 你属于黑队（三人局为独立截密者）。",color:"light_purple"}
execute as @a[tag=dc.audience,scores={dc_role=0}] run tellraw @s {text:"本轮轮空，无需提交提示或密码。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=1}] run tellraw @s {text:"本轮身份：加密者。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=2}] run tellraw @s {text:"本轮身份：解密者。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=3}] run tellraw @s {text:"本轮身份：拦截者。",color:"yellow"}
execute as @a[tag=dc.audience,scores={dc_role=4}] run tellraw @s {text:"本轮身份：解密者，兼任拦截。",color:"yellow"}
