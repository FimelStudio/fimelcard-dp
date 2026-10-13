
$data modify storage fimel_skform:runtime temp.rendered append value {type:"text",text:"$(text) ",color:"$(fg_0)",click_event:{action:"run_command",command:"/trigger fcs_ft_$(form_id)_$(key) set $(index)"}}
