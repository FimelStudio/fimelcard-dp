scoreboard players set @s go_sel -1
scoreboard players set @s go_undo 0
scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
scoreboard players set @a[tag=go.audience] go_view 0
function weiqi:visual/clear_estimate
function weiqi:ai/reset
scoreboard players add @s go_epoch 1
