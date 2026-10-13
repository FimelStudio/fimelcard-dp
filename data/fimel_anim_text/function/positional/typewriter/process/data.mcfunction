#tellraw @a {storage:"fimel_anim_text:runtime",nbt:"positional.typewriter"}

data modify entity @s text set value {storage:"fimel_anim_text:runtime",nbt:"positional.typewriter.template",interpret:true}

#tellraw @a {entity:"@s",nbt:"text"}