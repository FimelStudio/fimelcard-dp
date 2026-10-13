# 复制同实例字符实体状态，保证进行中的文字过场仍可计时和清理。
scoreboard players operation #anim_id fv_ctx = @s cgt.AnimText.entity.count
execute as @e[tag=cgt_anim_text.positional] if score @s cgt.AnimText.entity.count = #anim_id fv_ctx run function fimel_vendor:migrate_entity
function fimel_vendor:migrate_entity
