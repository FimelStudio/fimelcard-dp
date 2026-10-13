# 仅用于当前卡牌玩家或已确认属于本牌桌的旧动画实体。
execute if score @s cgt.AnimText.storage = @s cgt.AnimText.storage unless score @s fca_store = @s fca_store run scoreboard players operation @s fca_store = @s cgt.AnimText.storage
execute if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count unless score @s fca_id = @s fca_id run scoreboard players operation @s fca_id = @s cgt.AnimText.entity.count
execute if score @s cgt.AnimText.entity.style = @s cgt.AnimText.entity.style unless score @s fca_style = @s fca_style run scoreboard players operation @s fca_style = @s cgt.AnimText.entity.style
execute if score @s cgt.AnimText.entity.timer = @s cgt.AnimText.entity.timer unless score @s fca_timer = @s fca_timer run scoreboard players operation @s fca_timer = @s cgt.AnimText.entity.timer
execute if score @s cgt.AnimText.entity.timer.max = @s cgt.AnimText.entity.timer.max unless score @s fca_timer_max = @s fca_timer_max run scoreboard players operation @s fca_timer_max = @s cgt.AnimText.entity.timer.max
execute if score @s cgt.AnimText.entity.timer.start = @s cgt.AnimText.entity.timer.start unless score @s fca_timer_start = @s fca_timer_start run scoreboard players operation @s fca_timer_start = @s cgt.AnimText.entity.timer.start
execute if score @s cgt.AnimText.entity.timer.total = @s cgt.AnimText.entity.timer.total unless score @s fca_timer_total = @s fca_timer_total run scoreboard players operation @s fca_timer_total = @s cgt.AnimText.entity.timer.total
execute if score @s cgt.AnimText.player.count = @s cgt.AnimText.player.count unless score @s fca_player_id = @s fca_player_id run scoreboard players operation @s fca_player_id = @s cgt.AnimText.player.count
execute if score @s cgt.MathLight.storage = @s cgt.MathLight.storage unless score @s fcm_store = @s fcm_store run scoreboard players operation @s fcm_store = @s cgt.MathLight.storage
execute if score @s skapi.skapilib = @s skapi.skapilib unless score @s fcs_lib = @s fcs_lib run scoreboard players operation @s fcs_lib = @s skapi.skapilib
execute if score @s skapi.skapilib.life = @s skapi.skapilib.life unless score @s fcs_life = @s fcs_life run scoreboard players operation @s fcs_life = @s skapi.skapilib.life
execute if score @s skapi.arrays.temp = @s skapi.arrays.temp unless score @s fcs_arr_tmp = @s fcs_arr_tmp run scoreboard players operation @s fcs_arr_tmp = @s skapi.arrays.temp
execute if score @s skapi.arrays.var = @s skapi.arrays.var unless score @s fcs_arr_var = @s fcs_arr_var run scoreboard players operation @s fcs_arr_var = @s skapi.arrays.var
execute if score @s skapi.math = @s skapi.math unless score @s fcs_math = @s fcs_math run scoreboard players operation @s fcs_math = @s skapi.math
execute if score @s skapi.firework = @s skapi.firework unless score @s fcs_fw = @s fcs_fw run scoreboard players operation @s fcs_fw = @s skapi.firework
execute if score @s skapi.firework.launchtime = @s skapi.firework.launchtime unless score @s fcs_fw_time = @s fcs_fw_time run scoreboard players operation @s fcs_fw_time = @s skapi.firework.launchtime
execute if score @s skapi.firework.trigger = @s skapi.firework.trigger unless score @s fcs_fw_trigger = @s fcs_fw_trigger run scoreboard players operation @s fcs_fw_trigger = @s skapi.firework.trigger
execute if score @s skapi.animator.thisframe = @s skapi.animator.thisframe unless score @s fcs_an_frame = @s fcs_an_frame run scoreboard players operation @s fcs_an_frame = @s skapi.animator.thisframe
execute if score @s skapi.animator.targetframe = @s skapi.animator.targetframe unless score @s fcs_an_target = @s fcs_an_target run scoreboard players operation @s fcs_an_target = @s skapi.animator.targetframe
execute if score @s skapi.animator.color = @s skapi.animator.color unless score @s fcs_an_color = @s fcs_an_color run scoreboard players operation @s fcs_an_color = @s skapi.animator.color
execute if score @s skapi.animator.phy.vx = @s skapi.animator.phy.vx unless score @s fcs_an_vx = @s fcs_an_vx run scoreboard players operation @s fcs_an_vx = @s skapi.animator.phy.vx
execute if score @s skapi.animator.phy.vy = @s skapi.animator.phy.vy unless score @s fcs_an_vy = @s fcs_an_vy run scoreboard players operation @s fcs_an_vy = @s skapi.animator.phy.vy
execute if score @s skapi.animator.phy.g = @s skapi.animator.phy.g unless score @s fcs_an_g = @s fcs_an_g run scoreboard players operation @s fcs_an_g = @s skapi.animator.phy.g
execute if score @s skapi.animator.phy.t = @s skapi.animator.phy.t unless score @s fcs_an_t = @s fcs_an_t run scoreboard players operation @s fcs_an_t = @s skapi.animator.phy.t
execute if score @s skform.submit = @s skform.submit unless score @s fcs_form_submit = @s fcs_form_submit run scoreboard players operation @s fcs_form_submit = @s skform.submit
execute if score @s title.int = @s title.int unless score @s fbt_int = @s fbt_int run scoreboard players operation @s fbt_int = @s title.int
execute if score @s title.io = @s title.io unless score @s fbt_io = @s fbt_io run scoreboard players operation @s fbt_io = @s title.io
execute if score @s title.panel_id = @s title.panel_id unless score @s fbt_panel = @s fbt_panel run scoreboard players operation @s fbt_panel = @s title.panel_id
execute if entity @s[tag=cgt_anim_text.debug] run tag @s add fimel.anim_text.debug
tag @s remove cgt_anim_text.debug
execute if entity @s[tag=cgt_anim_text.local.actionbar] run tag @s add fimel.anim_text.local.actionbar
tag @s remove cgt_anim_text.local.actionbar
execute if entity @s[tag=cgt_anim_text.local.subtitle] run tag @s add fimel.anim_text.local.subtitle
tag @s remove cgt_anim_text.local.subtitle
execute if entity @s[tag=cgt_anim_text.local.title] run tag @s add fimel.anim_text.local.title
tag @s remove cgt_anim_text.local.title
execute if entity @s[tag=cgt_anim_text.mark] run tag @s add fimel.anim_text.mark
tag @s remove cgt_anim_text.mark
execute if entity @s[tag=cgt_anim_text.positional] run tag @s add fimel.anim_text.positional
tag @s remove cgt_anim_text.positional
execute if entity @s[tag=cgt_anim_text.positional.animation] run tag @s add fimel.anim_text.positional.animation
tag @s remove cgt_anim_text.positional.animation
execute if entity @s[tag=cgt_anim_text.positional.animation.center] run tag @s add fimel.anim_text.positional.animation.center
tag @s remove cgt_anim_text.positional.animation.center
execute if entity @s[tag=cgt_anim_text.positional.animation.drop] run tag @s add fimel.anim_text.positional.animation.drop
tag @s remove cgt_anim_text.positional.animation.drop
execute if entity @s[tag=cgt_anim_text.positional.animation.drop.billboard] run tag @s add fimel.anim_text.positional.animation.drop.billboard
tag @s remove cgt_anim_text.positional.animation.drop.billboard
execute if entity @s[tag=cgt_anim_text.positional.animation.drop.onground] run tag @s add fimel.anim_text.positional.animation.drop.onground
tag @s remove cgt_anim_text.positional.animation.drop.onground
execute if entity @s[tag=cgt_anim_text.positional.animation.marker] run tag @s add fimel.anim_text.positional.animation.marker
tag @s remove cgt_anim_text.positional.animation.marker
execute if entity @s[tag=cgt_anim_text.positional.animation.obfuscasted] run tag @s add fimel.anim_text.positional.animation.obfuscasted
tag @s remove cgt_anim_text.positional.animation.obfuscasted
execute if entity @s[tag=cgt_anim_text.positional.animation.temp] run tag @s add fimel.anim_text.positional.animation.temp
tag @s remove cgt_anim_text.positional.animation.temp
execute if entity @s[tag=cgt_anim_text.positional.animation.text] run tag @s add fimel.anim_text.positional.animation.text
tag @s remove cgt_anim_text.positional.animation.text
execute if entity @s[tag=cgt_anim_text.positional.typewriter] run tag @s add fimel.anim_text.positional.typewriter
tag @s remove cgt_anim_text.positional.typewriter
execute if entity @s[tag=cgt_anim_text.replace.actionbar] run tag @s add fimel.anim_text.replace.actionbar
tag @s remove cgt_anim_text.replace.actionbar
execute if entity @s[tag=cgt_anim_text.replace.subtitle] run tag @s add fimel.anim_text.replace.subtitle
tag @s remove cgt_anim_text.replace.subtitle
execute if entity @s[tag=cgt_anim_text.replace.title] run tag @s add fimel.anim_text.replace.title
tag @s remove cgt_anim_text.replace.title
execute if entity @s[tag=cgt_anim_text.storage] run tag @s add fimel.anim_text.storage
tag @s remove cgt_anim_text.storage
execute if entity @s[tag=skanimator.phy] run tag @s add fimel.skanimator.phy
tag @s remove skanimator.phy
execute if entity @s[tag=skanimator.text] run tag @s add fimel.skanimator.text
tag @s remove skanimator.text
execute if entity @s[tag=skfirework.e] run tag @s add fimel.skfirework.e
tag @s remove skfirework.e
execute if entity @s[tag=skfirework.lau] run tag @s add fimel.skfirework.lau
tag @s remove skfirework.lau
execute if entity @s[tag=skfirework.laut] run tag @s add fimel.skfirework.laut
tag @s remove skfirework.laut
execute if entity @s[tag=skfirework.load] run tag @s add fimel.skfirework.load
tag @s remove skfirework.load
execute if entity @s[tag=skfirework.spd] run tag @s add fimel.skfirework.spd
tag @s remove skfirework.spd
execute if entity @s[tag=skform.had] run tag @s add fimel.skform.had
tag @s remove skform.had
execute if entity @s[tag=skform.test] run tag @s add fimel.skform.test
tag @s remove skform.test
