execute unless score @s sp_ifull matches 1.. run title @s actionbar {text:"物品栏已满，请腾出空格；你的璀璨宝石资产会自动补回。",color:"yellow"}
scoreboard players set @s sp_ifull 100
return 0
