"""技能物品使用真实棋子；天才 1～6 直接并排，无翻页。"""
from build_magical_athlete_game import ROOT,put


def build():
    put('direct/choices',[
        'data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending',
        'data modify storage magical_athlete:direct options set from storage magical_athlete:ui pending.options',
        'data modify storage magical_athlete:direct kind set value "pending"',
        'execute if data storage magical_athlete:ui pending{kind:"genius"} run return run function magical_athlete:direct/genius_page',
        'function magical_athlete:direct/page',
        'execute if data storage magical_athlete:ui pending{kind:"twin"} run function magical_athlete:direct/special_tool with storage magical_athlete:direct'])
    page=[
        'clear @s *[minecraft:custom_data~{magical_athlete:{choice:1b}}]',
        'scoreboard players set @s ma_dpage 0',
        'data modify storage magical_athlete:direct options set value [1,2,3,4,5,6,0]']
    for slot in range(7):
        page += [f'function magical_athlete:direct/page_slot {{slot:{slot}}}']
    page += [
        # Rebuild starts with one expected die; dice_sync removes it during the
        # guess and subtracts one. Final total: 7 options + cancel (+ roster).
        'scoreboard players set @s ma_expected 9',
        'function magical_athlete:direct/cancel_tool with storage magical_athlete:direct']
    put('direct/genius_page',page)
    put('direct/choice_item',[
        '$execute if items entity @s hotbar.$(slot) * unless items entity @s hotbar.$(slot) *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return run function magical_athlete:direct/space_notice',
        '$data modify storage magical_athlete:ui choice set value {kind:"$(kind)",target:$(target),label:"$(label)",slot:$(slot),code:$(code),epoch:$(epoch),table:$(table),model:"minecraft:lime_dye"}',
        'function magical_athlete:direct/choice_model with storage magical_athlete:ui choice',
        'function magical_athlete:direct/choice_item_apply with storage magical_athlete:ui choice'])
    choose=[
        'execute if data storage magical_athlete:ui choice{target:-1} run data modify storage magical_athlete:ui choice.model set value "minecraft:barrier"',
        'execute if data storage magical_athlete:ui choice{kind:"genius",target:0} run data modify storage magical_athlete:ui choice.model set value "minecraft:barrier"',
        '$execute if data storage magical_athlete:ui choice{kind:"genius"} if predicate {condition:"minecraft:value_check",value:$(target),range:{min:1,max:6}} run data modify storage magical_athlete:ui choice.model set value "card:magical_athlete/guess/$(target)"']
    for kind in ('hypnotist','flip','duel','mastermind','copycat'):
        choose += [f'execute if data storage magical_athlete:ui choice{{kind:"{kind}"}} unless data storage magical_athlete:ui choice{{target:-1}} run function magical_athlete:direct/choice_racer_model with storage magical_athlete:ui choice']
    for kind in ('egg','twin'):
        choose += [f'execute if data storage magical_athlete:ui choice{{kind:"{kind}"}} unless data storage magical_athlete:ui choice{{target:-1}} run function magical_athlete:direct/choice_skill_model with storage magical_athlete:ui choice']
    put('direct/choice_model',choose)
    put('direct/choice_racer_model',[
        '$data modify storage magical_athlete:ui model_racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(target)]',
        'function magical_athlete:direct/choice_racer_character with storage magical_athlete:ui model_racer'])
    put('direct/choice_racer_character',[
        '$data modify storage magical_athlete:ui model_char set from storage magical_athlete:characters chars[$(char)]',
        'function magical_athlete:direct/choice_model_apply with storage magical_athlete:ui model_char'])
    put('direct/choice_skill_model',[
        '$data modify storage magical_athlete:ui model_char set from storage magical_athlete:characters chars[$(target)]',
        'function magical_athlete:direct/choice_model_apply with storage magical_athlete:ui model_char'])
    put('direct/choice_model_apply','$data modify storage magical_athlete:ui choice.model set value "card:magical_athlete/token/$(slug)"')
    put('direct/choice_item_apply','$item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_model="$(model)",minecraft:custom_name={text:"$(label)〔Q〕",color:"green",italic:false},minecraft:lore=[{text:"按Q一次确认此选项",color:"gray",italic:false}],minecraft:custom_data={magical_athlete:{tool:1b,choice:1b,code:$(code),epoch:$(epoch),table:$(table)}}]')
    # Existing IDs remain aliases of the same sculpture, but all public runtime
    # displays now explicitly use token/; hand/ keeps the hidden-lineup wrapper.
    for name in ('direct/pool_init','visual/racer_init'):
        path=ROOT/(name+'.mcfunction')
        put(name,path.read_text(encoding='utf-8').replace('card:magical_athlete/racer/','card:magical_athlete/token/'))


if __name__=='__main__':
    build()
