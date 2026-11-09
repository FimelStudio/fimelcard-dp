function catan:feedback/resource_gain with storage catan:feedback production[0]
data remove storage catan:feedback production[0]
execute if data storage catan:feedback production[0] run function catan:feedback/production
