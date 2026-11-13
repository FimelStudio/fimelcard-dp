data modify storage catan:visual color set value 1
function catan:visual/read_color with storage catan:visual
execute if data storage catan:visual {color:1} run data modify storage catan:visual color_name set value "red"
execute if data storage catan:visual {color:2} run data modify storage catan:visual color_name set value "blue"
execute if data storage catan:visual {color:3} run data modify storage catan:visual color_name set value "white"
execute if data storage catan:visual {color:4} run data modify storage catan:visual color_name set value "orange"
