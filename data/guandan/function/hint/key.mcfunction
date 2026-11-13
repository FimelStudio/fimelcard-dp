# 普通牌在前，炸弹按规则的强度排序，同等强度按牌型、张数和主点数排序。
scoreboard players set #hint_scale gd_ctx 100
scoreboard players operation #hint_key gd_ctx = #power gd_ctx
scoreboard players operation #hint_key gd_ctx *= #hint_scale gd_ctx
scoreboard players operation #hint_key gd_ctx += #kind gd_ctx
scoreboard players operation #hint_key gd_ctx *= #hint_scale gd_ctx
scoreboard players operation #hint_key gd_ctx += #size gd_ctx
scoreboard players operation #hint_key gd_ctx *= #hint_scale gd_ctx
scoreboard players operation #hint_key gd_ctx += #high gd_ctx
