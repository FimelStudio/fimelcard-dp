execute if entity @e[type=minecraft:marker,tag=ct.controller] run return run function cardtable:uninstall/table
execute if entity @a[tag=ct.uninstall_pending] run return run function cardtable:uninstall/next_player
execute if data storage fimel_skform:runtime database.scoreboards[0] run return run function cardtable:uninstall/dynamic_objective
function cardtable:uninstall/entities
advancement revoke @a only abraca:click/played_pile
advancement revoke @a only abraca:click/spell_button
advancement revoke @a only cardtable:click/end_vote
advancement revoke @a only cardtable:click/end_vote_attack
advancement revoke @a only cardtable:click/game_rules
advancement revoke @a only cardtable:click/game_rules_attack
advancement revoke @a only cardtable:click/game_settings
advancement revoke @a only cardtable:click/game_settings_attack
advancement revoke @a only cardtable:click/seat_1
advancement revoke @a only cardtable:click/seat_1_attack
advancement revoke @a only cardtable:click/seat_2
advancement revoke @a only cardtable:click/seat_2_attack
advancement revoke @a only cardtable:click/seat_3
advancement revoke @a only cardtable:click/seat_3_attack
advancement revoke @a only cardtable:click/seat_4
advancement revoke @a only cardtable:click/seat_4_attack
advancement revoke @a only cardtable:click/seat_5
advancement revoke @a only cardtable:click/seat_5_attack
advancement revoke @a only cardtable:click/seat_6
advancement revoke @a only cardtable:click/seat_6_attack
advancement revoke @a only cardtable:click/seat_7
advancement revoke @a only cardtable:click/seat_7_attack
advancement revoke @a only cardtable:click/seat_8
advancement revoke @a only cardtable:click/seat_8_attack
advancement revoke @a only cardtable:click/start_game
advancement revoke @a only cardtable:click/start_game_attack
advancement revoke @a only cardtable:click/switch_game
advancement revoke @a only cardtable:click/switch_game_attack
advancement revoke @a only chess:click_cell
advancement revoke @a only fast_card:button_click
advancement revoke @a only fimel_anim_text:player.count
advancement revoke @a only gomoku:click_cell
advancement revoke @a only hanabi:click/discard_pile
advancement revoke @a only hanabi:click/discard_pile_attack
advancement revoke @a only weiqi:click_cell
advancement revoke @a only xiangqi:click_cell
data modify storage cardtable:uninstall chunks set from storage cardtable:installation chunks
data modify storage cardtable:uninstall queue set value [{"id":"abraca:debug"},{"id":"abraca:hud"},{"id":"abraca:input"},{"id":"abraca:pile"},{"id":"abraca:title"},{"id":"aeroplane_chess:input"},{"id":"aeroplane_chess:layout"},{"id":"aeroplane_chess:runtime"},{"id":"aeroplane_chess:settings"},{"id":"aeroplane_chess:status"},{"id":"aeroplane_chess:ui"},{"id":"aeroplane_chess:visual"},{"id":"avalon:ballot"},{"id":"avalon:chat"},{"id":"avalon:heads"},{"id":"avalon:hud"},{"id":"avalon:map"},{"id":"avalon:name"},{"id":"avalon:names"},{"id":"avalon:reveal"},{"id":"avalon:ui"},{"id":"bullshit:dialog"},{"id":"bullshit:input"},{"id":"bullshit:result"},{"id":"cardtable:chairs"},{"id":"cardtable:deal"},{"id":"cardtable:debug"},{"id":"cardtable:hud"},{"id":"cardtable:installation"},{"id":"cardtable:layout"},{"id":"cardtable:menu"},{"id":"cardtable:picker"},{"id":"cardtable:session"},{"id":"cardtable:settings"},{"id":"cardtable:vote"},{"id":"cardtable:vote_click"},{"id":"catan:action"},{"id":"catan:direct"},{"id":"catan:engine"},{"id":"catan:feedback"},{"id":"catan:hud"},{"id":"catan:input"},{"id":"catan:layout"},{"id":"catan:ray"},{"id":"catan:runtime"},{"id":"catan:settings"},{"id":"catan:topology"},{"id":"catan:ui"},{"id":"catan:visual"},{"id":"chess:ai"},{"id":"chess:engine"},{"id":"chess:input"},{"id":"chess:runtime"},{"id":"chess:settings"},{"id":"chess:ui"},{"id":"chess:undo"},{"id":"chess:visual"},{"id":"critical_point:dialog"},{"id":"decrypto:digits"},{"id":"decrypto:form"},{"id":"decrypto:guess"},{"id":"decrypto:hud"},{"id":"decrypto:input"},{"id":"decrypto:marker"},{"id":"decrypto:notes"},{"id":"decrypto:page"},{"id":"decrypto:round"},{"id":"decrypto:sync"},{"id":"decrypto:title"},{"id":"decrypto:words"},{"id":"decrypto:wrap"},{"id":"doudizhu:counter"},{"id":"doudizhu:deck"},{"id":"doudizhu:hud"},{"id":"doudizhu:input"},{"id":"doudizhu:music"},{"id":"doudizhu:table_cards"},{"id":"doudizhu:ui"},{"id":"fast_card:deal"},{"id":"fast_card:debug"},{"id":"fast_card:transition"},{"id":"fimel_anim_text:runtime"},{"id":"fimel_math_light:runtime"},{"id":"fimel_skform:runtime"},{"id":"fimel_sklibs:animator"},{"id":"fimel_sklibs:arrays"},{"id":"fimel_sklibs:firework"},{"id":"fimel_sklibs:math"},{"id":"fimel_sklibs:player"},{"id":"fimel_sklibs:runtime"},{"id":"fimel_title:io"},{"id":"gomoku:coordinates"},{"id":"gomoku:ctx"},{"id":"gomoku:input"},{"id":"gomoku:layout"},{"id":"gomoku:ray"},{"id":"gomoku:runtime"},{"id":"gomoku:settings"},{"id":"gomoku:ui"},{"id":"gomoku:undo"},{"id":"gomoku:visual"},{"id":"guandan:bot"},{"id":"guandan:cards"},{"id":"guandan:deal"},{"id":"guandan:hint"},{"id":"guandan:hud"},{"id":"guandan:input"},{"id":"guandan:layout"},{"id":"guandan:name"},{"id":"guandan:probe"},{"id":"guandan:runtime"},{"id":"guandan:settings"},{"id":"guandan:ui"},{"id":"guandan:visual"},{"id":"hanabi:bar"},{"id":"hanabi:card"},{"id":"hanabi:cleanup"},{"id":"hanabi:dialog"},{"id":"hanabi:firework"},{"id":"hanabi:hud"},{"id":"hanabi:input"},{"id":"hanabi:item"},{"id":"hanabi:name"},{"id":"hanabi:reward"},{"id":"hanabi:rules"},{"id":"hanabi:test"},{"id":"hanabi:title"},{"id":"ito:form"},{"id":"ito:hud"},{"id":"ito:input"},{"id":"ito:name"},{"id":"ito:runtime"},{"id":"ito:themes"},{"id":"ito:ui"},{"id":"ito:visual"},{"id":"liars_holdem:action"},{"id":"liars_holdem:card"},{"id":"liars_holdem:dialog"},{"id":"liars_holdem:showdown"},{"id":"liars_holdem:transition"},{"id":"love_letter:chat"},{"id":"love_letter:deal"},{"id":"love_letter:input"},{"id":"love_letter:layout"},{"id":"love_letter:name"},{"id":"love_letter:private"},{"id":"love_letter:runtime"},{"id":"love_letter:settings"},{"id":"love_letter:ui"},{"id":"love_letter:visual"},{"id":"magical_athlete:action"},{"id":"magical_athlete:characters"},{"id":"magical_athlete:direct"},{"id":"magical_athlete:engine"},{"id":"magical_athlete:feedback"},{"id":"magical_athlete:hud"},{"id":"magical_athlete:input"},{"id":"magical_athlete:layout"},{"id":"magical_athlete:rules"},{"id":"magical_athlete:runtime"},{"id":"magical_athlete:settings"},{"id":"magical_athlete:ui"},{"id":"magical_athlete:visual"},{"id":"skull:hud"},{"id":"skull:io"},{"id":"skull:ui"},{"id":"skull:visual"},{"id":"splendor:action"},{"id":"splendor:affordable"},{"id":"splendor:cards"},{"id":"splendor:direct"},{"id":"splendor:engine"},{"id":"splendor:hud"},{"id":"splendor:inventory"},{"id":"splendor:layout"},{"id":"splendor:runtime"},{"id":"splendor:settings"},{"id":"splendor:visual"},{"id":"uno:animation"},{"id":"uno:hud"},{"id":"uno:input"},{"id":"uno:message"},{"id":"uno:name"},{"id":"uno:runtime"},{"id":"uno:settings"},{"id":"uno:ui"},{"id":"uno:visual"},{"id":"weiqi:coordinates"},{"id":"weiqi:input"},{"id":"weiqi:layout"},{"id":"weiqi:ray"},{"id":"weiqi:runtime"},{"id":"weiqi:settings"},{"id":"weiqi:ui"},{"id":"weiqi:visual"},{"id":"wenfei:catalog"},{"id":"wenfei:form"},{"id":"wenfei:io"},{"id":"wenfei:panel"},{"id":"wenfei:ui"},{"id":"wenfei:wrap"},{"id":"xiangqi:ai"},{"id":"xiangqi:engine"},{"id":"xiangqi:input"},{"id":"xiangqi:private"},{"id":"xiangqi:runtime"},{"id":"xiangqi:settings"},{"id":"xiangqi:ui"},{"id":"xiangqi:undo"},{"id":"xiangqi:visual"}]
schedule function cardtable:uninstall/storage_tick 1t replace
