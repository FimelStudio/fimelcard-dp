

# 移除用不到的Trigger计分板
# data modify storage fimel_skform:runtime temp.forms set from storage fimel_skform:runtime database.forms
# execute if data storage fimel_skform:runtime temp.forms[0] run function fimel_skform:tick/_for2
execute as @a[tag=fimel.skform.test,tag=!fimel.skform.had] run function fimel_skform:tick/_reset/_0

# 遍历Trigger计分板，修改表单数据
data modify storage fimel_skform:runtime temp.scoreboards set from storage fimel_skform:runtime database.scoreboards
execute if data storage fimel_skform:runtime temp.scoreboards[0] run function fimel_skform:tick/_for1

# 检测玩家是否提交了表单
execute as @a[tag=fimel.skform.had,scores={fcs_form_submit=1}] run function fimel_skform:tick/_submit/_0

