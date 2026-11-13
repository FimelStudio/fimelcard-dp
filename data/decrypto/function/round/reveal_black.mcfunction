function decrypto:player/audience
# 红队密码已结算；现在公开蓝队提示并处理蓝队密码。
tellraw @a[tag=dc.audience] [{text:'[蓝队提示] ',color:'blue'},{nbt:'black.1',storage:'decrypto:round',interpret:true,color:'light_purple'},{text:'　/　',color:'gray'},{nbt:'black.2',storage:'decrypto:round',interpret:true,color:'light_purple'},{text:'　/　',color:'gray'},{nbt:'black.3',storage:'decrypto:round',interpret:true,color:'light_purple'}]
tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'请讨论并填写蓝队密码。第一轮不进行拦截。',color:'yellow'}]
execute if score @s dc_round matches 1 run scoreboard players set @s dc_state 8
execute unless score @s dc_round matches 1 run scoreboard players set @s dc_state 7
# 将已公开提示保存在本桌控制器，避免持续显示读取到另一桌的临时存储。
data modify entity @s data.decrypto.active_clues set from storage decrypto:round black
function decrypto:hud/clues
function decrypto:round/open_guess
