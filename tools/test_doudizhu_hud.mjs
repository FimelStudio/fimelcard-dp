import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const stage=path.resolve('tools/doudizhu-hud');
const actual='C:/Users/Chen Yuru/AppData/Roaming/.minecraft/versions/26.2-Fabric 0.19.3/saves/卡牌游戏/datapacks/fimelcard-dp/data';
const read=n=>fs.readFileSync(path.join(stage,n+'.mcfunction'),'utf8');
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
let refs=0;
for(const f of walk(stage)){
 const text=fs.readFileSync(f,'utf8');
 for(const m of text.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g)){
  if(m[1]==='title')continue;
  assert(fs.existsSync(path.join(actual,m[1],'function',m[2]+'.mcfunction')) || m[1]==='doudizhu' && fs.existsSync(path.join(stage,m[2]+'.mcfunction')),m[0]);
  refs++;
 }
}
let neighborChecks=0;
for(let a=1;a<=6;a++)for(let b=a+1;b<=7;b++)for(let c=b+1;c<=8;c++){
 const seats=[a,b,c];
 for(let i=0;i<3;i++){
  const me=seats[i],up=Math.max(...seats.filter(s=>s<me),0)||Math.max(...seats);
  const lower=seats.filter(s=>s>me),down=lower.length?Math.min(...lower):Math.min(...seats);
  assert.equal(up,seats[(i+2)%3]);assert.equal(down,seats[(i+1)%3]);neighborChecks++;
 }
}
assert(read('hud/build').includes('#hud_up dd_ctx > @s dd_seat'));
assert(read('hud/build').includes('#hud_down dd_ctx < @s dd_seat'));
assert(read('hud/row').includes('if score @s dd_id = #hud_table dd_ctx if score @s dd_owner = #hud_owner dd_ctx'));
assert(!read('action/play').includes('text:" 剩余 "'));
assert(read('input/give_book').includes('minecraft:purple_dye'));
assert(read('input/drop').includes('minecraft:purple_dye'));
assert(read('system/upgrade_v3').includes('minecraft.dropped:minecraft.purple_dye'));
for(const slot of ['inventory.*','hotbar.*','weapon.offhand'])assert(read('input/sync_player').includes(slot));
for(const n of ['action/handle','dialog/open'])assert(read(n).includes('run return run function doudizhu:input/reject'));
assert(read('player/clear_state').includes('function doudizhu:hud/deactivate'));
assert(read('hud/deactivate').includes('title.panel_id = @s dd_prev_panel'));
assert(read('hud/build').includes('neg_text_buffer[-1].extra[0].extra[].font'));
const font=JSON.parse(fs.readFileSync('../fimelcard-rp/assets/card/font/doudizhu/hand_neg.json'));
for(let n=1;n<=54;n++)assert.equal(font.providers[0].advances[String.fromCharCode(0xe100+n)],-21.5);
assert.equal(font.providers[0].advances['\uE000'],21.5);
assert.equal(font.providers[0].advances['\uE001'],-1.5);
console.log(neighborChecks+' neighbor cases; '+refs+' local function references; dye, HUD, cleanup and font checks passed.');
