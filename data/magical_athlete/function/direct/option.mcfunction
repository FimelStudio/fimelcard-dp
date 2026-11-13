$scoreboard players set #option ma_ctx $(target)
$data modify storage magical_athlete:ui option set value {target:$(target),slot:$(slot),table:$(table),epoch:$(epoch)}
data modify storage magical_athlete:ui option.kind set from storage magical_athlete:ui pending.kind
scoreboard players operation #choice_code ma_ctx = #option ma_ctx
scoreboard players add #choice_code ma_ctx 2100
execute store result storage magical_athlete:ui option.code int 1 run scoreboard players get #choice_code ma_ctx
function magical_athlete:ui/option_label with storage magical_athlete:ui option
