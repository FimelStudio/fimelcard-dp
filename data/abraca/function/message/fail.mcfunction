scoreboard players operation #ctx ab_ctx = @s ab_id
tag @a[tag=ab.audience] remove ab.audience
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.audience
function abraca:message/fail_missing_spell
function abraca:sound/fail
tag @a[tag=ab.audience] remove ab.audience
