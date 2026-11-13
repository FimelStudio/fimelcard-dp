$tellraw @a[tag=ca.audience] [{text:"[卡坦岛] ",color:"gold"},{nbt:"data.catan.p$(winner).name",entity:"@s",interpret:true},{text:" 达到 10 分，获得胜利！",color:"gold"}]
$function cardtable:game/result/title {audience:"@a[tag=ca.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{nbt:"data.catan.p$(winner).name",entity:"@s",interpret:true}}
