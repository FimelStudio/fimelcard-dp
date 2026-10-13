
# CLS
tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"


# 给玩家加标签，已有表单
tag @s add fimel.skform.had
tag @s add fimel.skform.test

scoreboard players enable @s fcs_form_submit

# 保存玩家的表单信息和存储信息
$function fimel_sklibs:skapi_player/pdata/modify {base_path:"storage fimel_skform:runtime temp.pdata",path:"form_id",value:{v:"$(form_id)"}}
$function fimel_sklibs:skapi_player/pdata/modify {base_path:"storage fimel_skform:runtime temp.pdata",path:"func",value:{v:"$(func)"}}
#$function fimel_sklibs:skapi_player/pdata/modify {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage",value:{v:"$(storage)"}}

$data modify storage fimel_skform:runtime temp.form_id set value "$(form_id)"
#$data modify storage fimel_skform:runtime temp.storage_name set value "$(storage)"


# 创建trigger记分板，添加计分板表单维护项
$data modify storage fimel_skform:runtime temp.form set from storage fimel_skform:runtime reg.form.$(form_id)
function fimel_skform:show_form/_scoreboard

# 渲染表单文本
$data modify storage fimel_skform:runtime temp.form set from storage fimel_skform:runtime reg.form.$(form_id)
#$data modify storage fimel_skform:runtime temp.storage set from $(storage)
function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage",output:"storage fimel_skform:runtime temp.storage"}
data modify storage fimel_skform:runtime temp.rendered set value []
function fimel_skform:show_form/_render

# 显示表单文本
data modify storage fimel_skform:runtime temp.args_show.text set from storage fimel_skform:runtime temp.rendered
function fimel_skform:show_form/_show with storage fimel_skform:runtime temp.args_show
