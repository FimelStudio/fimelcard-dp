import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
// 只读存档诊断，不提供写回功能。输出仅包含牌桌实体，不输出玩家物品或聊天。
function nbt(b){
 let p=0;
 const number=(f,n)=>{const v=b[f](p);p+=n;return typeof v==='bigint'?v.toString():v;};
 const str=()=>{const n=number('readUInt16BE',2),v=b.toString('utf8',p,p+n);p+=n;return v;};
 function value(t){
  if(t===1)return number('readInt8',1);if(t===2)return number('readInt16BE',2);
  if(t===3)return number('readInt32BE',4);if(t===4)return number('readBigInt64BE',8);
  if(t===5)return number('readFloatBE',4);if(t===6)return number('readDoubleBE',8);
  if(t===8)return str();
  if(t===7||t===11||t===12){const n=number('readInt32BE',4);return Array.from({length:n},()=>value(({7:1,11:3,12:4})[t]));}
  if(t===9){const type=number('readUInt8',1),n=number('readInt32BE',4);return Array.from({length:n},()=>value(type));}
  if(t===10){const o={};let type;while((type=number('readUInt8',1))!==0){const k=str();o[k]=value(type);}return o;}
  throw Error('NBT type '+t);
 }
 const type=number('readUInt8',1);str();return value(type);
}
const walk=d=>fs.existsSync(d)?fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]):[];
const world=path.resolve(process.argv[2]||'../..');
const scoreFile=path.join(world,'data/minecraft/scoreboard.dat');
const sb=nbt(zlib.gunzipSync(fs.readFileSync(scoreFile)));
const scores={};
function collect(o){
 if(!o||typeof o!=='object')return;
 if((o.Objective||o.objective)&&(o.Name||o.name||o.holder)){
  const name=o.Name??o.name??o.holder,obj=o.Objective??o.objective;
  (scores[name]??={})[obj]=o.Score??o.score??0;
 }
 Object.values(o).forEach(collect);
}
collect(sb);
const uuid=e=>{if(typeof e.UUID==='string')return e.UUID;const parts=e.UUID??e.uuid;if(!Array.isArray(parts))return null;const h=parts.map(x=>(x>>>0).toString(16).padStart(8,'0')).join('');return h.slice(0,8)+'-'+h.slice(8,12)+'-'+h.slice(12,16)+'-'+h.slice(16,20)+'-'+h.slice(20);};
const found=[];
for(const file of walk(path.join(world,'dimensions')).filter(f=>/[\\/]entities[\\/].*\.mca$/.test(f))){
 const b=fs.readFileSync(file);
 if(b.length===0)continue;
 if(b.length<8192)throw Error('区块头不完整 '+file);
 for(let i=0;i<1024;i++){
  const off=b.readUIntBE(i*4,3)*4096;if(!off)continue;
  const length=b.readUInt32BE(off),type=b[off+4],compressed=b.subarray(off+5,off+4+length);
  if(type&128)throw Error('外部区块须另行检查 '+file);
  const root=nbt(type===2?zlib.inflateSync(compressed):type===1?zlib.gunzipSync(compressed):compressed);
  for(const e of root.Entities??root.entities??[]){
   const tags=e.Tags??e.tags??[];
   if(tags.some(t=>t.startsWith('ct.'))||e.id==='minecraft:interaction')found.push({file:path.relative(world,file),id:e.id,pos:e.Pos??e.pos,tags,data:e.data,width:e.width,height:e.height,scores:scores[uuid(e)]??{},uuid:uuid(e)});
  }
 }
}
const vehicles=[];
for(const file of walk(path.join(world,'players')).filter(f=>f.endsWith('.dat'))){
 const root=nbt(zlib.gunzipSync(fs.readFileSync(file)));
 const rv=root.RootVehicle??root.root_vehicle;
 if(rv){const e=rv.Entity??rv.entity;vehicles.push({file:path.relative(world,file),id:e?.id,pos:e?.Pos??e?.pos,tags:e?.Tags??e?.tags,scores:scores[uuid(e)]??{}});}
}
console.log(JSON.stringify({scoreboardKeys:Object.keys(sb),scoreHolders:Object.keys(scores).length,entities:found,playerVehicles:vehicles},null,2));
