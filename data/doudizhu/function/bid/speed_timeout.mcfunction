function doudizhu:player/audience
dialog clear @a[tag=dd.audience]
tellraw @a[tag=dd.audience] {text:"手速制：15秒内无人叫地主，重新发牌，本局不计分。",color:"yellow"}
function doudizhu:deal/start
