$execute if items entity @s hotbar.$(slot) * unless items entity @s hotbar.$(slot) *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return run function magical_athlete:direct/space_notice
$data modify storage magical_athlete:ui choice set value {kind:"$(kind)",target:$(target),label:"$(label)",slot:$(slot),code:$(code),epoch:$(epoch),table:$(table),model:"minecraft:lime_dye"}
function magical_athlete:direct/choice_model with storage magical_athlete:ui choice
function magical_athlete:direct/choice_item_apply with storage magical_athlete:ui choice
