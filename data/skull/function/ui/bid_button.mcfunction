scoreboard players set #candidate sk_ctx 0
$scoreboard players set #candidate sk_ctx $(number)
execute unless score #candidate sk_ctx > @s sk_bid run return 0
execute if score #candidate sk_ctx > @s sk_total run return 0
execute if score #candidate sk_ctx < @a[tag=sk.viewer,limit=1] sk_count run return 0
$function skull:ui/button {choice:$(choice),label:"叫 $(number) 张花"}
