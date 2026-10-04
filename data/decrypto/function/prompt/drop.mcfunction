tag @e[tag=dc.prompt_drop] remove dc.prompt_drop
tag @s add dc.prompt_drop
execute on origin if entity @s[tag=dc.player] at @s run function decrypto:prompt/open
kill @s
tag @e[tag=dc.form_controller] remove dc.form_controller
