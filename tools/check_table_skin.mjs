import fs from 'node:fs';
import assert from 'node:assert/strict';
const base='data/cardtable/function/';const read=p=>fs.readFileSync(base+p+'.mcfunction','utf8');
const rp='C:/Users/Chen Yuru/Desktop/fimelcard-rp/assets/card/';
for(const cap of [4,8]){
 const s=read('skin/elegant'+cap);const matches=[...s.matchAll(/positioned ~(-?[\d.]+) ~(-?[\d.]+) ~(-?[\d.]+) summon minecraft:item_display run function cardtable:skin\/item \{model:"([^"]+)",yaw:(-?[\d.]+)\}/g)].map(m=>({x:+m[1],y:+m[2],z:+m[3],model:m[4],yaw:+m[5]}));
 const tables=matches.filter(m=>m.model==='table'),chairs=matches.filter(m=>m.model==='sofa'),corners=matches.filter(m=>m.model==='corner'),flowers=matches.filter(m=>m.model.includes('flower'));
 assert.equal(tables.length,cap===4?9:16);assert.equal(chairs.length,cap);assert.equal(corners.length,4);assert.equal(flowers.length,4);
 assert.equal(new Set(tables.map(m=>m.x+','+m.z)).size,tables.length);
 for(const f of flowers)assert.ok(corners.some(c=>c.x===f.x&&c.z===f.z&&c.y+1===f.y));
 const axis=cap===4?[-1,0,1]:[-1.5,-.5,.5,1.5];for(const x of axis)for(const z of axis)assert.ok(tables.some(t=>t.x===x&&t.z===z));
 for(const c of chairs){assert.equal(c.y,.5);assert.equal(c.yaw,c.z<0&&Math.abs(c.z)>Math.abs(c.x)?0:c.x>0&&Math.abs(c.x)>Math.abs(c.z)?90:c.z>0&&Math.abs(c.z)>Math.abs(c.x)?-180:-90);}
 assert.equal(read('skin/default'+cap).split('\n').filter(l=>l.startsWith('setblock ')).length,tables.length);
 assert.ok(!s.includes('summon minecraft:interaction'));
}
for(const name of ['table','sofa','corner','sunflower','pink_flower']){
 const item=JSON.parse(fs.readFileSync(rp+'items/table_skin/'+name+'.json','utf8'));
 assert.equal(item.model.model,'card:table_skin/'+name);
 const model=JSON.parse(fs.readFileSync(rp+'models/table_skin/'+name+'.json','utf8'));
 assert.ok(model.elements.length>0);assert.ok(!model.parent);
 for(const t of Object.values(model.textures)){if(t.startsWith('card:'))assert.ok(fs.existsSync(rp+'textures/'+t.slice(5)+'.png'));else assert.ok(t.startsWith('block/'),'Unexpected external dependency '+t);}
 if(name==='sofa')assert.equal(item.model.tints[1].value,0xB02E26);
}
const skinFiles=fs.readdirSync(base+'skin').filter(f=>f.endsWith('.mcfunction'));
for(const f of skinFiles){const s=read('skin/'+f.replace('.mcfunction',''));for(const m of s.matchAll(/function ([\w]+):([\w/]+)/g))assert.ok(fs.existsSync('data/'+m[1]+'/function/'+m[2]+'.mcfunction'));assert.ok(!/kill @e.*tag=ct\.seat/.test(s));
 for(const l of s.split('\n')){if(l.startsWith('#'))continue;const stack=[];let quote='',escape=false;for(const c of l){if(quote){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===quote)quote='';}else if(c==='"'||c==="'")quote=c;else if('[{'.includes(c))stack.push(c);else if(']}'.includes(c))assert.equal(stack.pop(),c===']'?'[':'{');}assert.equal(stack.length,0,f);assert.equal(quote,'',f);}}
assert.match(read('skin/handle'),/unless score @s ct_id = @s ct_skin_table/);
assert.match(read('skin/handle'),/ct_state=0/);assert.match(read('skin/apply'),/ct_id = #skin_table ct_ctx run kill @s/);
assert.match(read('skin/item'),/ct_id = #skin_table ct_ctx/);
assert.match(read('skin/open'),/function cardtable:game\/open_settings/);
assert.match(read('click/game_settings'),/function cardtable:skin\/open/);
assert.match(read('table/remove'),/ct_skin matches 1.*skin\/default4/);
assert.match(read('table/remove'),/ct_skin matches 1.*skin\/default8/);
console.log('PASS: 4/8-seat layouts, 5 furniture models/textures, red tint, scoped cleanup, trigger guards, settings routing, restoration, function references and syntax structure.');

const atlas=JSON.parse(fs.readFileSync(rp+'../minecraft/atlases/blocks.json','utf8'));
for(const name of ['sofa','corner','sunflower','pink_flower']){const model=JSON.parse(fs.readFileSync(rp+'models/table_skin/'+name+'.json','utf8'));for(const texture of Object.values(model.textures).filter(t=>t.startsWith('card:')))assert.ok(atlas.sources.some(s=>s.type==='minecraft:single'&&s.resource===texture&&s.sprite===texture),'Missing atlas registration: '+texture);}
console.log('PASS: All custom furniture textures are registered in the block atlas.');

const itemAtlas=JSON.parse(fs.readFileSync(rp+"../minecraft/atlases/items.json","utf8"));
for(const s of atlas.sources.filter(s=>s.resource?.startsWith("card:table_skin/")))assert.ok(itemAtlas.sources.some(i=>i.resource===s.resource&&i.sprite===s.sprite));
console.log("PASS: 26.2 item atlas includes the furniture textures.");
