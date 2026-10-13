scoreboard players set #storage.output.id.test fca_store 0

$execute if entity @e[type=marker,tag=fimel.anim_text.storage,tag=$(id)] run return run scoreboard players set #storage.output.id.test fca_store 2

execute if data storage fimel_anim_text:runtime storage.output.data{id:""} run return run scoreboard players set #storage.output.id.test fca_store 1