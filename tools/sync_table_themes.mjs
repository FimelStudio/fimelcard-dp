import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const from='C:/Users/Chen Yuru/Desktop/fimelcard-rp';
const to='C:/Users/Chen Yuru/AppData/Roaming/.minecraft/versions/26.2-Fabric 0.19.3/resourcepacks/fimelcard-rp';
assert(fs.existsSync(to+'/pack.mcmeta'));
const m=JSON.parse(fs.readFileSync('docs/牌桌新增皮肤资源.json','utf8'));
const files=m.models.flatMap(x=>['assets/card/models/table_skin/'+x.name+'.json','assets/card/items/table_skin/'+x.name+'.json']);
for(const t of m.textures){const p='assets/card/textures/'+t.slice(5)+'.png';files.push(p);if(fs.existsSync(from+'/'+p+'.mcmeta'))files.push(p+'.mcmeta');}
files.push('喵工坊家具来源说明.md');
for(const p of files){fs.mkdirSync(path.dirname(to+'/'+p),{recursive:true});fs.copyFileSync(from+'/'+p,to+'/'+p);assert(fs.readFileSync(from+'/'+p).equals(fs.readFileSync(to+'/'+p)));}
for(const name of ['blocks','items']){
 const p='assets/minecraft/atlases/'+name+'.json';const original=fs.existsSync(to+'/'+p)?JSON.parse(fs.readFileSync(to+'/'+p)):{sources:[]};
 for(const texture of m.textures){if(!original.sources.some(s=>s.resource===texture&&s.sprite===texture))original.sources.push({type:'minecraft:single',resource:texture,sprite:texture});}
 fs.mkdirSync(path.dirname(to+'/'+p),{recursive:true});fs.writeFileSync(to+'/'+p,JSON.stringify(original,null,2)+'\n');
}
console.log('已同步并逐文件校验 '+files.length+' 个家具资源文件，合并两个图集，保留其他现有资源。');
