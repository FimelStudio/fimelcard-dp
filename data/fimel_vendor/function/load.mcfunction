# 内置前置先创建独立状态，再加载各游戏；升级迁移只执行一次。
scoreboard objectives add fv_ctx dummy
scoreboard objectives add fbt_external dummy
scoreboard objectives add fca_id dummy
scoreboard objectives add fca_style dummy
scoreboard objectives add fca_timer dummy
scoreboard objectives add fca_timer_max dummy
scoreboard objectives add fca_timer_start dummy
scoreboard objectives add fca_timer_total dummy
scoreboard objectives add fca_player_id dummy
scoreboard objectives add fca_store dummy
scoreboard objectives add fcm_store dummy
scoreboard objectives add fcs_an_color dummy
scoreboard objectives add fcs_an_g dummy
scoreboard objectives add fcs_an_t dummy
scoreboard objectives add fcs_an_vx dummy
scoreboard objectives add fcs_an_vy dummy
scoreboard objectives add fcs_an_target dummy
scoreboard objectives add fcs_an_frame dummy
scoreboard objectives add fcs_arr_tmp dummy
scoreboard objectives add fcs_fw dummy
scoreboard objectives add fcs_fw_time dummy
scoreboard objectives add fcs_fw_trigger trigger
scoreboard objectives add fcs_math dummy
scoreboard objectives add fcs_lib dummy
scoreboard objectives add fcs_life dummy
scoreboard objectives add fcs_form_submit trigger
scoreboard objectives add fbt_int dummy
scoreboard objectives add fbt_io dummy
scoreboard objectives add fbt_panel dummy
execute unless score #migration fv_ctx matches 1 if score #version ct_ctx matches 1.. run function fimel_vendor:migrate
scoreboard players set #migration fv_ctx 1
function fimel_sklibs:skapi_arrays/native/init
function fimel_sklibs:skapi_math/native/init
function fimel_sklibs:skapi_player/native/init
function fimel_sklibs:skapi_init/init
function fimel_sklibs:skapi/init
function fimel_sklibs:skfirework/init
function fimel_sklibs:animator/init
function fimel_skform:init
function fimel_anim_text:_initialize_/load
function fimel_math_light:load
function fimel_title:code/load
