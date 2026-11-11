function doudizhu:team/totals
execute if score #orange_total dd_ctx > #aqua_total dd_ctx run tellraw @a[tag=dd.audience] {text:"橙队获胜！",color:"gold",bold:true}
execute if score #aqua_total dd_ctx > #orange_total dd_ctx run tellraw @a[tag=dd.audience] {text:"青队获胜！",color:"aqua",bold:true}
execute if score #orange_total dd_ctx = #aqua_total dd_ctx run tellraw @a[tag=dd.audience] {text:"两队同分，平局。",color:"yellow"}
function doudizhu:game/abort
