import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
import assert from 'node:assert/strict';
import {decodeNBT,encodeNBT} from './generate_table8.mjs';
const read=(ns,n)=>fs.readFileSync('data/'+ns+'/function/'+n+'.mcfunction','utf8');
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
// 新四人桌只替换四块实体楼梯，旧模板和所有其他方块保持原样。
const old4=decodeNBT(zlib.gunzipSync(fs.readFileSync('data/cardtable/structure/table4.nbt')));
const new4=decodeNBT(zlib.gunzipSync(fs.readFileSync('data/cardtable/structure/table4_display.nbt')));
assert.deepEqual(new4.value.size,old4.value.size);
assert.deepEqual(new4.value.palette,old4.value.palette);
assert.deepEqual(new4.value.entities,old4.value.entities);
let changed4=0;
for(const [i,b] of old4.value.blocks.value.items.entries()){
 const next=new4.value.blocks.value.items[i];
 assert.deepEqual(next.pos,b.pos);
 if(old4.value.palette.value.items[b.state.value].Name.value==='minecraft:birch_stairs'){
  assert.equal(new4.value.palette.value.items[next.state.value].Name.value,'minecraft:air');changed4++;
 }else assert.deepEqual(next,b);
}
assert.equal(changed4,4);
const c4=[...read('cardtable','table/spawn_chairs4').matchAll(/#new_seat ct_ctx (\d+)\s+execute positioned ~(-?[\d.]+) ~ ~(-?[\d.]+)/g)];
assert.deepEqual(c4.map(m=>m.slice(1).map(Number)),[[1,0,-2],[2,2,0],[3,0,2],[4,-2,0]]);
assert.ok(read('cardtable','table/build').includes('cardtable:table4_display ~-2 ~ ~-2'));
assert.ok(read('cardtable','table/build').includes('unless score @s ct_capacity matches 8 run function cardtable:table/spawn_chairs4'));
assert.ok(!read('cardtable','table/spawn_seats').includes('spawn_chairs4'),'自定义桌椅不重复生成椅子');
for(const f of ['load','tick','table/ensure_seats'])assert.ok(!read('cardtable',f).includes('spawn_chairs4'),'旧四座桌不迁移');
for(const [i,dir]of ['north','east','south','west'].entries()){
 const pos=[[2,0,0],[4,0,2],[2,0,4],[0,0,2]][i];
 const b=old4.value.blocks.value.items.find(b=>b.pos.value.items.join()===pos.join());
 assert.equal(old4.value.palette.value.items[b.state.value].Properties.value.facing.value,dir);
 assert.ok(read('cardtable','seat/chair4_init').includes('ct_seat matches '+(i+1)+' run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"'+dir+'"'));
}
assert.match(read('cardtable','seat/chair4_init'),/translation:\[-0.5f,0f,-0.5f\]/);
assert.match(read('cardtable','seat/chair4_init'),/tag @s add ct.part/);
assert.match(read('cardtable','seat/chair4_init'),/ct_id = #seat_owner ct_ctx/);
console.log('通过：新四人桌仅四张椅子改为展示实体，坐标朝向对齐；旧桌和自定义桌椅不迁移。');
// 结构仅保留16格桌面；8把椅子改为独立方块展示实体，交互中心逐一重合。
const raw=zlib.gunzipSync(fs.readFileSync('data/cardtable/structure/table8.nbt'));
const nbt=decodeNBT(raw);
assert.deepEqual(encodeNBT(nbt),raw);
assert.deepEqual(nbt.value.size.value.items,[6,1,6]);
assert.equal(nbt.value.entities.value.items.length,0);
const blocks=nbt.value.blocks.value.items.map(b=>({pos:b.pos.value.items,block:nbt.value.palette.value.items[b.state.value]}));
assert.equal(blocks.length,36);
assert.equal(new Set(blocks.map(b=>b.pos.join(','))).size,36);
const chairs=blocks.filter(b=>b.block.Name.value==='minecraft:birch_stairs');
const surface=blocks.filter(b=>['minecraft:oak_stairs','minecraft:oak_planks'].includes(b.block.Name.value));
assert.equal(chairs.length,0);assert.equal(surface.length,16);
for(const b of surface)assert.ok(b.pos[0]>=1&&b.pos[0]<=4&&b.pos[2]>=1&&b.pos[2]<=4);
const spawns=[...read('cardtable','table/spawn_seats8').matchAll(/#new_seat ct_ctx (\d+)\s+execute positioned ~(-?[\d.]+) ~0.32 ~(-?[\d.]+)/g)];
assert.equal(spawns.length,8);
const expected=[[-1,-2.5],[1,-2.5],[2.5,-1],[2.5,1],[1,2.5],[-1,2.5],[-2.5,1],[-2.5,-1]];
const chairSpawns=[...read('cardtable','table/spawn_chairs8').matchAll(/#new_seat ct_ctx (\d+)\s+execute positioned ~(-?[\d.]+) ~ ~(-?[\d.]+) summon minecraft:block_display/g)];
assert.equal(chairSpawns.length,8);
const migration=read('cardtable','table/migrate_chairs8');
const chairInit=read('cardtable','seat/chair8_init');
for(const [i,m]of spawns.entries()){
 assert.equal(Number(m[1]),i+1);
 const x=Number(m[2]),z=Number(m[3]);assert.deepEqual([x,z],expected[i]);
 assert.deepEqual(chairSpawns[i].slice(1).map(Number),[i+1,x,z]);
 assert.ok(migration.includes('scores={ct_seat='+(i+1)+'}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~'+x+' ~0.32 ~'+z));
 if(i%2===0){const [nx,nz]=expected[i+1];assert.equal(Math.hypot(nx-x,nz-z),2);}
 assert.equal(Math.min(Math.abs(x),Math.abs(z)),1);
 assert.ok(chairInit.includes('ct_seat matches '+(Math.floor(i/2)*2+1)+'..'+(Math.floor(i/2)*2+2)+' run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"'+['north','east','south','west'][Math.floor(i/2)]+'"'));
 for(const suffix of ['', '_attack']){
  const a=JSON.parse(fs.readFileSync('data/cardtable/advancement/click/seat_'+(i+1)+suffix+'.json','utf8'));
  assert.ok(a.criteria.click.conditions.entity.some(c=>c.scores?.ct_kind===i+11));
  assert.equal(a.rewards.function,'cardtable:click/seat_'+(i+1));
  assert.ok(read('cardtable','click/seat_'+(i+1)).includes('revoke @s only cardtable:click/seat_'+(i+1)+suffix));
 }
}
assert.match(chairInit,/tag @s add ct.part/);
assert.match(chairInit,/ct_id = #seat_owner ct_ctx/);
assert.match(chairInit,/translation:\[-0.5f,0f,-0.5f\]/);
assert.equal([...migration.matchAll(/run setblock/g)].length,8);
assert.equal([...migration.matchAll(/execute if block .*minecraft:birch_stairs\[facing=/g)].length,8);
assert.ok(!migration.includes('game/abort')&&!migration.includes('place template'));
assert.match(migration,/on passengers if entity @s\[type=minecraft:player\] run tag @s add ct.reseat8/);
assert.match(migration,/as @a\[tag=ct.reseat8\] at @s run function cardtable:seat\/mount/);
for(const file of ['load','tick'])assert.match(read('cardtable',file),/ct_capacity=8.*chairs_version:1.*function cardtable:table\/migrate_chairs8/);
assert.match(read('cardtable','seat/init8'),/ct_id = #seat_owner ct_ctx/);
assert.match(read('cardtable','seat/remount_click'),/ct_id = #clicked_id ct_ctx if score @s ct_seat = #clicked_seat/);
assert.match(read('cardtable','table/remove'),/tag=ct.part.*ct_id = #ctx_id/);
assert.match(read('cardtable','table/migrate_v13'),/unless score @s ct_capacity matches 8 unless data.*migrate_v12/);
assert.ok(!read('cardtable','table/migrate_v13').includes('game/abort'));
assert.ok(read('cardtable','table/init').includes('menu_version:13'));
assert.match(read('cardtable','admin/create8_safe'),/positioned ~ ~-1 ~ run function cardtable:admin\/create8/);
assert.match(read('cardtable','admin/create8'),/execute align xyz summon minecraft:marker/);
assert.ok(read('cardtable','table/build').includes('table8 ~-3 ~ ~-3'));
assert.match(read('cardtable','menu/people'),/\$\(people\)\/\$\(capacity\)/);
for(const group of ['rules','vote']){
 const texts=[...read('cardtable',group+'/text8').matchAll(/summon minecraft:text_display ~(-?[\d.]+) ~0.58 ~(-?[\d.]+)/g)];
 assert.equal(texts.length,4);
 for(const m of texts){
  assert.equal(Math.max(Math.abs(Number(m[1])),Math.abs(Number(m[2]))),2.015);
  if(group==='rules')assert.equal(Math.min(Math.abs(Number(m[1])),Math.abs(Number(m[2]))),1.4);
 }
 assert.ok(read('cardtable',group+'/render').includes('if score @s ct_capacity matches 8 run function'));
}
const ruleClicks=[...read('cardtable','rules/spawn8').matchAll(/summon minecraft:interaction ~(-?[\d.]+) ~0.5625 ~(-?[\d.]+)/g)];
assert.equal(ruleClicks.length,4);
assert.equal([...read('cardtable','rules/spawn8').matchAll(/width:0.50f/g)].length,4);
for(const m of ruleClicks){
 const x=Number(m[1]),z=Number(m[2]);
 assert.equal(Math.max(Math.abs(x),Math.abs(z)),1.765);
 assert.equal(Math.min(Math.abs(x),Math.abs(z)),1.4);
 assert.ok(Math.hypot(x,z,.5625)<4,'规则实体须在绑定范围内');
 for(const [sx,sz] of expected)assert.ok(Math.abs(x-sx)>.73||Math.abs(z-sz)>.73,'规则交互不能与椅子重叠');
}
assert.ok(read('cardtable','rules/render').includes('distance=..4'));
assert.ok(read('cardtable','rules/render').includes('rules_version:5'));
assert.ok(read('cardtable','tick').includes('rules_version:5'));
// 使用源码中的轮换边界和扫描次数穷举稀疏座位，保证5至8号不会被跳过或卡住。
const bwWrap=Number(read('bullshit','round/scan_smart').match(/bw_turn matches (\d+)\.\./)[1]);
const bwScans=[...read('bullshit','round/begin').matchAll(/run function bullshit:round\/scan_smart|^function bullshit:round\/scan_smart/gm)].length;
assert.equal(bwWrap,9);assert.equal(bwScans,8);
let games=0;
for(let mask=1;mask<256;mask++){
 const seats=Array.from({length:8},(_,i)=>i+1).filter(s=>mask&(1<<(s-1)));
 if(seats.length<3)continue;
 for(const first of seats){
  let turn=first-1;if(turn===0)turn=8;
  const seen=[];
  for(let round=0;round<seats.length;round++){
   let found=false;
   for(let scan=0;scan<bwScans;scan++){turn++;if(turn>=bwWrap)turn=1;if(seats.includes(turn)){found=true;break;}}
   assert.ok(found);seen.push(turn);
  }
  assert.equal(seen[0],first);
  assert.deepEqual([...seen].sort((a,b)=>a-b),seats);
  games++;
 }
}
assert.match(read('bullshit','dialog/prepare_options'),/bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat/);
assert.equal([...read('bullshit','dialog/prepare_options').matchAll(/run function bullshit:dialog\/append_option/g)].length,8);
assert.ok(read('bullshit','action/handle').includes('401..408'));
assert.ok(read('bullshit','action/handle').includes('301..308'));
assert.ok(read('bullshit','round/resolve').includes('@a[tag=bw.audience,tag=bw.smart,limit=1]'));
assert.ok(!read('bullshit','round/resolve').includes('tellraw @a[tag=bw.player]'));
assert.match(read('bullshit','system/maintenance'),/unless score #online bw_ctx = #expected bw_ctx run function bullshit:game\/abort/);
// 人数页与文本页组合：每份回答的每一行最终均可见，每页不超过四人。
assert.ok(read('wenfei','title/render').includes('#batches wq_ctx /= #four wq_ctx'));
assert.ok(read('wenfei','title/group').includes('#answer_batch wq_ctx = #batch wq_ctx run return 0'));
for(let people=2;people<=8;people++){
 for(let guesser=1;guesser<=people;guesser++){
  const answers=Array.from({length:people},(_,i)=>i+1).filter(s=>s!==guesser);
  const batches=Math.floor((people+2)/4),seen=new Set();
  for(let page=0;page<batches*16;page++){
   const batch=page%batches,textPage=Math.floor(page/batches);
   const displayed=answers.filter((s,i)=>Math.floor(i/4)===batch);
   assert.ok(displayed.length<=4);
   for(const seat of displayed){
    const rowCount=seat+1,localPage=textPage%Math.ceil(rowCount/2);
    for(const row of [localPage*2,localPage*2+1])if(row<rowCount)seen.add(seat+':'+row);
   }
  }
  for(const seat of answers)for(let row=0;row<seat+1;row++)assert.ok(seen.has(seat+':'+row));
 }
}
for(let n=2;n<=8;n++)assert.equal(Math.floor(n/2)+1,[2,2,3,3,4,4,5][n-2]);
assert.match(read('cardtable','vote/count'),/ct_capacity matches 8 run scoreboard players operation #vote_need ct_ctx \/= #two/);
for(const game of [1,2,3,4,5,6,7,8,9]){
 let next=game%9+1;
 assert.equal(next,({1:2,2:3,3:4,4:5,5:6,6:7,7:8,8:9,9:1})[game]);
}
for(const file of ['game/start','menu/next_game','menu/render'])assert.ok(!read('cardtable',file).includes('ct_capacity matches 8 if score @s ct_game matches 7'));
// 检查受影响命名空间的真实文件引用、括号和宏标记；所有JSON也必须可解析。
let functions=0,jsons=0;
for(const file of walk('data')){
 if(file.endsWith('.json')){JSON.parse(fs.readFileSync(file,'utf8'));jsons++;}
 if(!file.endsWith('.mcfunction')||!/^data[\\/](cardtable|bullshit|wenfei)[\\/]/.test(file))continue;
 functions++;
 const source=fs.readFileSync(file,'utf8');
 for(const m of source.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g)){
  const target='data/'+m[1]+'/function/'+m[2]+'.mcfunction';
  if(!['title','cgt_anim_text'].includes(m[1]))assert.ok(fs.existsSync(target),file+': '+target);
 }
 for(const line of source.replace(/\\\r?\n\s*/g,'').split(/\r?\n/)){
  if(!line||line.startsWith('#'))continue;
  // 允许将客户端模板占位符作为普通字符串保存；不把所有$(...)都当函数宏。
  const stack=[];let q='',escape=false;
  for(const c of line){
   if(q){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===q)q='';}
   else if(c==='"'||c==="'")q=c;
   else if('[{('.includes(c))stack.push(c);
   else if(']})'.includes(c))assert.equal(stack.pop(),{']':'[','}':'{',')':'('}[c],file);
  }
  assert.equal(q,'',file);assert.equal(stack.length,0,file);
 }
}
console.log('通过：4×4桌面、8张椅子及交互对齐、双桌归属、旧桌迁移、菜单、投票、'+games+'种瞎掰王轮换、回答分页。');
console.log('通过：'+functions+'个函数的引用与结构，'+jsons+'个JSON；仍需Minecraft内八人联机验收。');
