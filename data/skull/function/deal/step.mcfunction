function skull:player/audience
scoreboard players operation #seat sk_ctx = @s sk_deal_seat
scoreboard players set #present sk_ctx 0
execute as @a[tag=sk.audience] if score @s sk_seat = #seat sk_ctx run scoreboard players set #present sk_ctx 1
execute if score #present sk_ctx matches 1 run function skull:deal/card
scoreboard players add @s sk_deal_slot 1
execute if score @s sk_deal_slot matches 5 run scoreboard players add @s sk_deal_seat 1
execute if score @s sk_deal_slot matches 5 run scoreboard players set @s sk_deal_slot 1
