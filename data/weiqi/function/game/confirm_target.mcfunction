function weiqi:engine/check_move
execute unless score #legal go_ctx matches 1 run return run function weiqi:game/illegal
function weiqi:game/select
