import fs from 'node:fs';
import assert from 'node:assert/strict';
const manifest=JSON.parse(fs.readFileSync('docs/牌桌新增皮肤资源.json','utf8'));
const base='data/cardtable/function/';const read=n=>fs.readFileSync(base+n+'.mcfunction','utf8');
const rp='C:/Users/Chen Yuru/Desktop/fimelcard-rp/assets/';
const dialog=JSON.parse(read('skin/dialog').split('] ')[1]);
assert.equal(dialog.actions.length,8);
assert.equal(new Set(dialog.actions.map(a=>a.action.command)).size,8);
for(const theme of manifest.themes){
 assert(dialog.actions.some(a=>a.action.command==='trigger ct_skin_pick set '+(theme.id+3)));
 assert(read('skin/picker').includes(`ct_skin matches ${theme.id} run function`));
 for(const cap of [4,8]){
  const s=read('skin/'+theme.key+cap);
  const parts=[...s.matchAll(/positioned ~(-?[\d.]+) ~(-?[\d.]+) ~(-?[\d.]+).*model:"([^"]+)",yaw:(-?[\d.]+)/g)].map(m=>({x:+m[1],y:+m[2],z:+m[3],model:m[4],yaw:+m[5]}));
  const chairs=parts.filter(p=>p.model===theme.models.chair),tables=parts.filter(p=>p.model===theme.models.table),corners=parts.filter(p=>p.model===theme.models.corner),props=parts.filter(p=>theme.models.props.includes(p.model));
  assert.equal(tables.length,cap===4?9:16);assert.equal(chairs.length,cap);assert.equal(corners.length,4);assert.equal(props.length,4);
  const axis=cap===4?[-1,0,1]:[-1.5,-.5,.5,1.5];for(const x of axis)for(const z of axis)assert(tables.some(t=>t.x===x&&t.z===z));
  for(const c of chairs){assert.equal(c.y,.5);assert.equal(Math.max(Math.abs(c.x),Math.abs(c.z)),cap===4?2:2.5);}
  for(const p of props){const c=corners.find(c=>c.x===p.x&&c.z===p.z);const b=manifest.models.find(m=>m.name===c.model).bounds;assert(Math.abs(p.y-(c.y+b.max[1]/16))<1e-5);}
  assert(!s.includes('minecraft:interaction'));
  assert(read('skin/apply').includes(`function cardtable:skin/${theme.key}${cap}`));
 }
}
for(const m of manifest.models){
 const item=JSON.parse(fs.readFileSync(rp+'card/items/table_skin/'+m.name+'.json'));
 const model=JSON.parse(fs.readFileSync(rp+'card/models/table_skin/'+m.name+'.json'));
 assert.equal(item.model.model,'card:table_skin/'+m.name);assert(model.elements.length);
 for(const texture of Object.values(model.textures).filter(t=>t.startsWith('card:'))){
  assert(fs.existsSync(rp+'card/textures/'+texture.slice(5)+'.png'));
  for(const a of ['blocks','items']){const atlas=JSON.parse(fs.readFileSync(rp+'minecraft/atlases/'+a+'.json'));assert(atlas.sources.some(s=>s.resource===texture&&s.sprite===texture));}
 }
 if(m.name.includes('_prop')){assert(m.bounds.max[0]-m.bounds.min[0]<=12.00001);assert(m.bounds.max[2]-m.bounds.min[2]<=12.00001);const lift=m.customModelData===153031?0.8:0;assert(m.bounds.max[1]<=14.00001+lift);assert(Math.abs(m.bounds.min[1]-lift)<1e-5);}
}
for(const n of ['table/remove','table/spawn_chairs4','table/spawn_chairs8'])assert(read(n).includes('ct_skin matches 1..6'));
assert(read('skin/open').includes('ct_skin matches 0..6'));
// Interpret selection score operations, ensure UI action ID isn't changed mid-dispatch.
for(const [choice,expected] of [[1,0],[2,1],[5,2],[6,3],[7,4],[8,5],[9,6]]){
 let scores={ '#skin_choice':choice};
 for(let line of read('skin/select').split(/\r?\n/)){
  if(line.startsWith('execute if score #skin_value ct_ctx matches 5..9 run ')){
   if(scores['#skin_value']<5||scores['#skin_value']>9)continue;
   line=line.split(' run ')[1];
  }
  let m=line.match(/^scoreboard players operation (#\w+) ct_ctx = (#\w+) ct_ctx$/);if(m)scores[m[1]]=scores[m[2]];
  m=line.match(/^scoreboard players remove (#\w+) ct_ctx (\d+)$/);if(m)scores[m[1]]-=+m[2];
 }
 assert.equal(scores['#skin_value'],expected);assert.equal(scores['#skin_choice'],choice);
}
console.log('PASS: 五套双尺寸布局、25个模型、纹理与双图集、装饰边界/落点、七种设置路由、默认椅抑制及移除恢复。');
