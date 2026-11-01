function guandan:cards/constants
kill @e[tag=gd.cards]
scoreboard players operation #level gd_ctx = @s gd_level
scoreboard players set #build gd_ctx 0
function guandan:deck/next
