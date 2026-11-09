$tellraw @a[tag=ca.audience] [{text:"[卡坦岛] ",color:"gold"},{nbt:"data.catan.p$(winner).name",entity:"@s",interpret:true},{text:" 达到 10 分，获得胜利！",color:"gold"}]
# feedback-v1
$execute as @a[tag=ca.audience,scores={ca_side=$(winner)}] run function catan:feedback/subtitle {"text":{"text":"卡坦岛胜利！","color":"gold"}}
