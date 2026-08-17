# 当前执行者是已翻开的公共牌实体；记录牌图并统计本次Dialog可见公共牌数量
$function liars_holdem:swap/load_option {key:"$(key)"}
scoreboard players add #swap_public_count lh_ctx 1
