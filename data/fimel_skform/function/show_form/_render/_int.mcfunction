
# say int!

execute unless data storage fimel_skform:runtime temp.i.default run data modify storage fimel_skform:runtime temp.i.default set value 0
$execute unless data storage fimel_skform:runtime temp.storage.$(key) run function fimel_skform:show_form/_render/__init with storage fimel_skform:runtime temp.i

execute unless data storage fimel_skform:runtime temp.i.fg run data modify storage fimel_skform:runtime temp.i.fg set value "#FFFF00"

function fimel_skform:show_form/_render/_int/_0 with storage fimel_skform:runtime temp.i

data modify storage fimel_skform:runtime temp.rendered append value {type:"text",text:"\u00a7r"}


return 1
