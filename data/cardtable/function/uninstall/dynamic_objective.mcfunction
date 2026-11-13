function cardtable:uninstall/dynamic_remove with storage fimel_skform:runtime database.scoreboards[0]
data remove storage fimel_skform:runtime database.scoreboards[0]
schedule function cardtable:uninstall/step 1t replace
