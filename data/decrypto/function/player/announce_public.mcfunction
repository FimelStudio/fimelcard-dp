function decrypto:player/audience
tellraw @a[tag=dc.audience] {text:"════ 本轮公开分工 ════",color:"aqua",bold:true}
tellraw @a[tag=dc.audience] {text:"白队（合作队）",color:"white"}
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=0}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：轮空",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=1}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：加密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=2}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=3}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：拦截",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=1,dc_role=4}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密兼拦截",color:"gray"}]
tellraw @a[tag=dc.audience] {text:"黑队（三人局截密者）",color:"light_purple"}
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=0}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：轮空",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=1}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：加密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=2}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=3}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：拦截",color:"gray"}]
execute as @a[tag=dc.audience,scores={dc_team=2,dc_role=4}] run tellraw @a[tag=dc.audience] [{selector:"@s",color:"gold"},{text:"：解密兼拦截",color:"gray"}]
