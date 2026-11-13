$data modify storage decrypto:guess row.contents.extra append value {text:"[ $(digit) ]",color:"$(color)",bold:true,click_event:{action:"run_command",command:"/trigger dc_action set $(command)"},hover_event:{action:"show_text",value:{text:"选择 $(digit)"}}}
data modify storage decrypto:guess row.contents.extra append value {text:"   "}
