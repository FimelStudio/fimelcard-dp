
# 对于每个玩家

execute as @a[tag=fimel.skform.had] run function fimel_skform:tick/_for1/_0 with storage fimel_skform:runtime temp.scoreboards[0]



data remove storage fimel_skform:runtime temp.scoreboards[0]
execute if data storage fimel_skform:runtime temp.scoreboards[0] run function fimel_skform:tick/_for1


