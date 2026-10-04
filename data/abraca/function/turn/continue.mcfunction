# 成功施法后继续按Q，或丢出第9格黑色染料结束。
execute as @a[tag=ab.actor,limit=1] run function abraca:ui/open_cast
tellraw @a[tag=ab.actor,limit=1] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'可继续施法，或按Q丢出第9格黑色染料，补牌并交给下一位玩家。',color:'gray'}]
