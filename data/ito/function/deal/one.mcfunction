tag @e[tag=it.dealing] remove it.dealing
tag @e[tag=it.cards,scores={it_owner=-1},sort=random,limit=1] add it.dealing
scoreboard players operation @e[tag=it.dealing,limit=1] it_owner = #deal_owner it_ctx
scoreboard players operation @e[tag=it.dealing,limit=1] it_slot = #deal_slot it_ctx
scoreboard players add #deal_slot it_ctx 1
tag @e[tag=it.dealing] remove it.dealing
