function doudizhu:team/migrate_score
tellraw @a[tag=dd.audience] [{text:"橙队累计 ",color:"gold",bold:true},{score:{name:"@s",objective:"dd_team_one"},color:"gold"},{text:"　青队累计 ",color:"aqua",bold:true},{score:{name:"@s",objective:"dd_team_two"},color:"aqua"}]
