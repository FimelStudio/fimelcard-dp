
$data modify storage fimel_skform:runtime temp.rendered append value {type:"nbt",storage:"fimel_skform:runtime",nbt:"temp.storage.$(key)",color:"$(fg)",click_event:{action:"suggest_command",command:"/trigger fcs_ft_$(form_id)_$(key) set "}}
