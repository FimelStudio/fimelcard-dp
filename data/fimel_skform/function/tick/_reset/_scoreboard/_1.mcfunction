

# $say $(form_id)_$(key)

# 移除计分板
$scoreboard objectives remove fcs_ft_$(form_id)_$(key)

# 移除计分板维护项
$data remove storage fimel_skform:runtime database.scoreboards[{scoreboard:"fcs_ft_$(form_id)_$(key)"}]

# 这个没了，用不着移除了
# 移除表单维护项
# $data remove storage fimel_skform:runtime database.forms[{v:"$(form_id)"}]

