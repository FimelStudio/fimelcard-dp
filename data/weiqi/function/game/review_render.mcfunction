scoreboard players operation #frame go_ctx = @s go_review
function weiqi:engine/review
execute if data entity @s data.weiqi.finalresult store result score @s go_result run data get entity @s data.weiqi.finalresult
function weiqi:visual/review
function weiqi:ui/refresh
