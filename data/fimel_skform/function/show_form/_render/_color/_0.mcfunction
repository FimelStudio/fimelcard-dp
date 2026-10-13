
# say color_RENDER

# $data modify storage fimel_skform:runtime temp.rendered append value {type:"text",text:"█$(hex_color)",color:"#$(hex_color)",click_event:{action:"suggest_command",command:"/trigger fcs_ft_$(form_id)_$(key) set "}}

$data modify storage fimel_skform:runtime temp.rendered append value {type:"text",text:"█",color:"#$(hex_color)",click_event:{action:"suggest_command",command:"/trigger fcs_ft_$(form_id)_$(key) set "}}

data modify storage fimel_skform:runtime temp.rendered append value {text:"\u00a7r"}
