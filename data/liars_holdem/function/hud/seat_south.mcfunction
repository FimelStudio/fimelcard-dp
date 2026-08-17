function liars_holdem:hud/load_count {seat:3}
execute if score #hud_bullets lh_ctx matches 1.. run function liars_holdem:hud/spawn_bullet {x:0.56f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 2.. run function liars_holdem:hud/spawn_bullet {x:0.40f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 3.. run function liars_holdem:hud/spawn_bullet {x:0.24f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 4.. run function liars_holdem:hud/spawn_bullet {x:0.08f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 5.. run function liars_holdem:hud/spawn_bullet {x:-0.08f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 6.. run function liars_holdem:hud/spawn_bullet {x:-0.24f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 7.. run function liars_holdem:hud/spawn_bullet {x:-0.40f,z:0.98f,rot:0f,seat:3}
execute if score #hud_bullets lh_ctx matches 8.. run function liars_holdem:hud/spawn_bullet {x:-0.56f,z:0.98f,rot:0f,seat:3}
