

# 添加计分板
$scoreboard objectives add fcs_ft_$(form_id)_$(key) trigger

# Enable玩家的Trigger计分板
# say enable
$scoreboard players enable @s fcs_ft_$(form_id)_$(key)
$scoreboard players set @s fcs_ft_$(form_id)_$(key) -2147483648

# 如果数据已添加则返回
$execute if data storage fimel_skform:runtime database.scoreboards[{form_id:"$(form_id)",key:"$(key)"}] run return 0

# 添加计分板维护项
data modify storage fimel_skform:runtime database.scoreboards append value {}
$data modify storage fimel_skform:runtime database.scoreboards[-1].scoreboard set value "fcs_ft_$(form_id)_$(key)"
data modify storage fimel_skform:runtime database.scoreboards[-1].key set from storage fimel_skform:runtime temp.i.key
data modify storage fimel_skform:runtime database.scoreboards[-1].type set from storage fimel_skform:runtime temp.i.type
data modify storage fimel_skform:runtime database.scoreboards[-1].form_id set from storage fimel_skform:runtime temp.form_id

# 颜色值限定区间
execute if data storage fimel_skform:runtime temp.i{type:"color"} run data modify storage fimel_skform:runtime temp.i.max set value 16777215
execute if data storage fimel_skform:runtime temp.i{type:"color"} run data modify storage fimel_skform:runtime temp.i.min set value 0

# 最大最小值限定
execute if data storage fimel_skform:runtime temp.i.max run data modify storage fimel_skform:runtime database.scoreboards[-1].max set from storage fimel_skform:runtime temp.i.max
execute if data storage fimel_skform:runtime temp.i.min run data modify storage fimel_skform:runtime database.scoreboards[-1].min set from storage fimel_skform:runtime temp.i.min



# $execute if data storage fimel_skform:runtime database.forms[{v:"$(form_id)"}] run return 0

# 添加表单维护项
# data modify storage fimel_skform:runtime database.forms append value {}
# data modify storage fimel_skform:runtime database.forms[-1].v set from storage fimel_skform:runtime temp.form_id
