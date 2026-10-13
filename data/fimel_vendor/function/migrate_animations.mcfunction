# 根实体的游戏标签证明归属，再按动画实例 ID 接管字符实体。
execute as @e[tag=fc.transition] if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count run function fimel_vendor:migrate_animation_root
execute as @e[tag=lh.transition] if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count run function fimel_vendor:migrate_animation_root
execute as @e[tag=hb.transition] if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count run function fimel_vendor:migrate_animation_root
execute as @e[tag=ab.transition] if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count run function fimel_vendor:migrate_animation_root
execute as @e[tag=dd.transition] if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count run function fimel_vendor:migrate_animation_root
