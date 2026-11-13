data modify storage love_letter:chat message append value {"text":"；","color":"white"}
data modify storage love_letter:chat message append from entity @s data.ll_name
data modify storage love_letter:chat message append value {"text":" 出局","color":"red"}
function love_letter:game/chat/feedback
