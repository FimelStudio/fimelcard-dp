import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const source='C:/Users/Chen Yuru/Desktop/喵工坊/喵工坊家具26.2/NyaaWorks喵工坊-r2.2-fixed/assets/minecraft';
const rp='C:/Users/Chen Yuru/Desktop/fimelcard-rp';
const table='data/cardtable/function/skin/';
const overrides=JSON.parse(fs.readFileSync(source+'/models/item/firework_star.json','utf8')).overrides;
const write=(p,v)=>{fs.mkdirSync(path.dirname(p),{recursive:true});fs.writeFileSync(p,typeof v==='string'?v:JSON.stringify(v,null,2)+'\n');};
const textures=new Set();const models=[];
function bounds(model){
 const points=[];
 for(const e of model.elements){for(let bits=0;bits<8;bits++){
 let v=e.from.map((x,k)=>bits&(1<<k)?e.to[k]:x);
 if(e.rotation){const {axis,angle,origin,rescale}=e.rotation;const a={x:0,y:1,z:2}[axis],u=(a+1)%3,w=(a+2)%3,rad=angle*Math.PI/180;v=v.map((x,k)=>x-origin[k]);const p=v[u],q=v[w];v[u]=p*Math.cos(rad)-q*Math.sin(rad);v[w]=p*Math.sin(rad)+q*Math.cos(rad);if(rescale){v[u]/=Math.cos(rad);v[w]/=Math.cos(rad);}v=v.map((x,k)=>x+origin[k]);}
 points.push(v);
 }}
 return {min:[0,1,2].map(k=>Math.min(...points.map(p=>p[k]))),max:[0,1,2].map(k=>Math.max(...points.map(p=>p[k])))};
}
function importModel(name,id,tint=0xffffff,fit=null){
 const src=overrides.find(o=>o.predicate.custom_model_data===id)?.model;assert(src,`Missing ${id}`);
 const m=JSON.parse(fs.readFileSync(source+'/models/'+src.replace('minecraft:','')+'.json','utf8'));
 assert(m.elements?.length&&!m.parent,src);
 delete m.display;delete m.groups;
 // 芭菲原模型把透明杯壁排在不透明内容物前，物品渲染时会遮掉内部。
 // 保留全部几何与UV，仅将玻璃杯底、杯柱、双面杯壁和杯口放到最后。
 if(id===153031){const glass=new Set([0,1,2,3,5,6,7,8]);m.elements=[...m.elements.filter((_,i)=>!glass.has(i)),...m.elements.filter((_,i)=>glass.has(i))];}

 for(const [key,ref] of Object.entries(m.textures||{})){
 const loc=ref.replace('minecraft:','');if(loc.startsWith('#')||loc.startsWith('block/')||loc.startsWith('item/'))continue;
 const srcTex=source+'/textures/'+loc+'.png';assert(fs.existsSync(srcTex),srcTex);
 const dest='table_skin/nyaa/'+loc.replace(/^nw\//,'');const tex='card:'+dest;
 const target=rp+'/assets/card/textures/'+dest+'.png';fs.mkdirSync(path.dirname(target),{recursive:true});fs.copyFileSync(srcTex,target);
 if(fs.existsSync(srcTex+'.mcmeta'))fs.copyFileSync(srcTex+'.mcmeta',target+'.mcmeta');
 m.textures[key]=tex;textures.add(tex);
 }
 if(fit){const b=bounds(m);const size=b.max.map((v,k)=>v-b.min[k]);const scale=Math.min(fit.width/Math.max(size[0],size[2]),fit.height/size[1]);
 const center=[(b.min[0]+b.max[0])/2,b.min[1],(b.min[2]+b.max[2])/2];
 const transform=p=>p.map((v,k)=>+( (v-center[k])*scale+(k===1?0:8)).toFixed(6));
 for(const e of m.elements){e.from=transform(e.from);e.to=transform(e.to);if(e.rotation)e.rotation.origin=transform(e.rotation.origin);}
 }
 // 芭菲整体上移0.05格，避免薄杯底与桌面重叠；资源重载即可更新旧实体。
 if(id===153031)for(const e of m.elements){e.from[1]+=0.8;e.to[1]+=0.8;if(e.rotation)e.rotation.origin[1]+=0.8;}
 const b=bounds(m);write(rp+'/assets/card/models/table_skin/'+name+'.json',m);
 write(rp+'/assets/card/items/table_skin/'+name+'.json',{model:{type:'minecraft:model',model:'card:table_skin/'+name,tints:[{type:'minecraft:constant',value:0xffffff},{type:'minecraft:constant',value:tint}]}});
 models.push({name,sourceModel:src,customModelData:id,tint,bounds:b});return name;
}
const themes=[
 {id:2,key:'electro',name:'电音',description:'磨制黑石桌面、青蓝沙发，四角分别为调音台、舞台音箱、抹茶芭菲和效果器。',table:[10786],chair:[25037,0x32b8ce],corner:[25041],props:[[153000],[153065],[153031],[153013]]},
 {id:3,key:'toys',name:'玩偶',description:'樱花木木板桌面、粉色沙发，四角卡比与Fumo玩偶。',table:[17015],chair:[25037,0xef92ba],corner:[25042],props:[[101013,0xf59ac2],[101008]]},
 {id:4,key:'vintage',name:'复古',description:'深色橡木木板桌面、棕色沙发，欧式茶几配台灯与留声机。',table:[15015],chair:[25037,0x79503b],corner:[25038],props:[[25033],[25046]]},
 {id:5,key:'bamboo',name:'竹影',description:'竹马赛克桌面、竹木扶手椅，四角竹盆栽与团状多肉盆栽。',table:[20016],chair:[20025,0x94a76a],chairOffset:0,corner:[20016],props:[[100011,0xd4c4a0],[100003,0xd4c4a0]]},
 {id:6,key:'garden',name:'春日',description:'去皮白桦原木桌面、薄荷绿扶手椅，四角雏菊与向日葵。',table:[12014],chair:[12025,0x8fbf98],chairOffset:0,corner:[25042],props:[[100001,0xffe8bd],[100010,0xd3e7ed]]}
];
for(const t of themes){
 t.models={table:importModel(t.key+'_table',...t.table),chair:importModel(t.key+'_chair',...t.chair),corner:importModel(t.key+'_corner',t.corner[0],t.corner[1],{width:16,height:16}),props:t.props.map((p,i)=>importModel(t.key+'_prop'+i,p[0],p[1],{width:12,height:14}))};
 for(const cap of [4,8]){
 let s='# '+t.name+'：保留座位交互和桌号，装饰仅位于四角。\n';
 s+=cap===4?'fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:barrier\n':'fill ~-2 ~ ~-2 ~1 ~ ~1 minecraft:barrier\n';
 const add=(x,y,z,model,yaw=0)=>{s+=`execute positioned ~${x} ~${y} ~${z} summon minecraft:item_display run function cardtable:skin/item {model:"${model}",yaw:${yaw}}\n`;};
 const axis=cap===4?[-1,0,1]:[-1.5,-.5,.5,1.5];for(const x of axis)for(const z of axis)add(x,.5,z,t.models.table);
 const seats=cap===4?[[0,-2,0],[2,0,90],[0,2,-180],[-2,0,-90]]:[[-1,-2.5,0],[1,-2.5,0],[2.5,-1,90],[2.5,1,90],[1,2.5,-180],[-1,2.5,-180],[-2.5,1,-90],[-2.5,-1,-90]];
 for(const [x,z,yaw] of seats){s+=`execute if block ~${x} ~ ~${z} minecraft:birch_stairs run setblock ~${x} ~ ~${z} minecraft:air\n`;add(x,.5,z,t.models.chair,((yaw+(t.chairOffset||0)+540)%360)-180);}
 const r=cap===4?2:2.5;for(const [i,[x,z]] of [[-r,-r],[r,-r],[r,r],[-r,r]].entries()){add(x,.5,z,t.models.corner);const corner=models.find(m=>m.name===t.models.corner);const top=corner.bounds.max[1]/16;add(x,top+.5,z,t.models.props[i%t.models.props.length],x===z?45:-45);}
 write(table+t.key+cap+'.mcfunction',s);
 }
}
for(const atlas of ['blocks','items']){const p=rp+'/assets/minecraft/atlases/'+atlas+'.json';const json=JSON.parse(fs.readFileSync(p,'utf8'));for(const texture of textures)if(!json.sources.some(s=>s.resource===texture&&s.sprite===texture))json.sources.push({type:'minecraft:single',resource:texture,sprite:texture});write(p,json);}
write('docs/牌桌新增皮肤资源.json',{themes,models,textures:[...textures]});
console.log('生成五套4/8人布局、'+models.length+'个模型与物品定义，注册'+textures.size+'张自定义纹理。');
