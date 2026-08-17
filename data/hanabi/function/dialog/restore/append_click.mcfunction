$data modify storage hanabi:dialog restore_piece.click_event set value {action:"run_command",command:"trigger hb_action set $(restore_action)"}
data modify storage hanabi:dialog restore_view.extra append from storage hanabi:dialog restore_piece
scoreboard players add #restore_added hb_ctx 1
