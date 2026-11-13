// 只读检查图标选游界面，不调用依赖个人桌面素材的图标生成器。
import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
import assert from 'node:assert/strict';

const read=n=>fs.readFileSync('data/cardtable/function/'+n+'.mcfunction','utf8').replace(/\r\n/g,'\n');
const names=['Fast Card','赌命德州扑克','花火','出包魔法师','瞎掰王','谍报风云','临界点','问非所答','骷髅牌','斗地主','UNO','国际象棋','中国象棋','五子棋','飞行棋','阿瓦隆','情书','掼蛋','命悬一线','围棋','卡坦岛','璀璨宝石','胡闹运动会'];
const min=[4,2,2,2,3,3,3,2,2,1,2,1,1,1,1,5,2,1,2,1,3,2,2];
const max=[4,8,5,5,8,8,6,8,6,3,8,2,2,2,4,8,6,4,8,2,4,4,6];
const ai=new Set([10,12,13,14,15,18,20]);
const ids=names.map((_,i)=>i+1),count=ids.length,highest=Math.max(...ids);
const rp=path.resolve('../../../..','resourcepacks/fimelcard-rp');
const font=JSON.parse(fs.readFileSync(path.join(rp,'assets/card/font/game_icons.json'),'utf8'));
const bitmaps=font.providers.filter(p=>p.type==='bitmap');
const space=font.providers.find(p=>p.type==='space');
assert.equal(bitmaps.length,count);assert.ok(space);
const allChars=new Set();

// 解码RGBA PNG，以真实透明边界验证切片字距；无需额外图片库。
function rgbaPng(file){
 const data=fs.readFileSync(file);
 assert.equal(data.subarray(0,8).toString('hex'),'89504e470d0a1a0a',file);
 let pos=8,width,height,channels;const compressed=[];
 while(pos<data.length){
  const length=data.readUInt32BE(pos),kind=data.toString('ascii',pos+4,pos+8),part=data.subarray(pos+8,pos+8+length);
  if(kind==='IHDR'){
   width=part.readUInt32BE(0);height=part.readUInt32BE(4);
   assert.equal(part[8],8);assert.equal(part[9],6);assert.equal(part[12],0);channels=4;
  }
  if(kind==='IDAT')compressed.push(part);
  pos+=length+12;
 }
 const raw=zlib.inflateSync(Buffer.concat(compressed)),stride=width*channels,pixels=Buffer.alloc(stride*height);
 assert.equal(raw.length,(stride+1)*height);
 for(let y=0;y<height;y++){
  const filter=raw[y*(stride+1)];assert.ok(filter<=4);
  for(let x=0;x<stride;x++){
   const a=x>=channels?pixels[y*stride+x-channels]:0,b=y?pixels[(y-1)*stride+x]:0,c=y&&x>=channels?pixels[(y-1)*stride+x-channels]:0;
   let predicted=0;
   if(filter===1)predicted=a;
   if(filter===2)predicted=b;
   if(filter===3)predicted=Math.floor((a+b)/2);
   if(filter===4){const p=a+b-c,pa=Math.abs(p-a),pb=Math.abs(p-b),pc=Math.abs(p-c);predicted=pa<=pb&&pa<=pc?a:pb<=pc?b:c;}
   pixels[y*stride+x]=(raw[y*(stride+1)+1+x]+predicted)&255;
  }
 }
 return {width,height,pixels};
}

for(const id of ids){
 const provider=bitmaps.find(p=>p.file===`card:gui/game_icons/${id}.png`);assert.ok(provider,'缺少图标字体映射 '+id);
 assert.equal(provider.height,9);assert.equal(provider.ascent,8);assert.equal(provider.chars.length,8);
 const image=rgbaPng(path.join(rp,`assets/card/textures/gui/game_icons/${id}.png`));
 assert.equal(image.width,256);assert.equal(image.height,256);
 const columns=[...provider.chars[0]].length,cellWidth=image.width/columns,cellHeight=image.height/provider.chars.length;
 assert.ok(cellWidth<=256&&cellHeight<=256,'FontTexture原始字形切片不能超过256');
 for(let strip=0;strip<8;strip++){
  const ch=String.fromCodePoint(0xE600+id*8+strip),gap=String.fromCodePoint(0xE800+id*8+strip);
  assert.equal(provider.chars[strip],ch);assert.ok(!allChars.has(ch));allChars.add(ch);
  let right=0;
  for(let y=strip*32;y<(strip+1)*32;y++)for(let x=0;x<256;x++)if(image.pixels[(y*256+x)*4+3])right=Math.max(right,x+1);
  assert.ok(right>0,'图标切片不能全透明');
  const advance=Math.floor(right*provider.height/cellHeight+.5)+1;
  assert.equal(advance+space.advances[gap],80,'切片加间距必须恰好80像素');
 }
}

let iconCount=0,sliceCount=0;
for(const cap of [4,8]){
 const src=read('menu/picker/show'+cap),dialog=JSON.parse(src.slice(src.indexOf('{')));
 const shown=ids.filter(id=>cap===8||min[id-1]<=4);
 assert.equal(dialog.type,'minecraft:notice');assert.equal(dialog.pause,false);assert.equal(dialog.after_action,'close');
 assert.equal(dialog.action.label.text,'取消');assert.equal(dialog.action.action,undefined);
 assert.equal(dialog.body.length,1+Math.ceil(shown.length/5));assert.equal(dialog.title.text,`选择游戏 · ${cap}人桌`);
 for(const [row,block] of dialog.body.slice(1).entries()){
  assert.equal(block.type,'minecraft:plain_message');assert.equal(block.width,410);
  const rowIds=shown.slice(row*5,row*5+5),pieces=block.contents.extra;
  let offset=0;
  for(let strip=0;strip<8;strip++){
   for(const id of rowIds){
    const tile=pieces[offset++],gap=pieces[offset++],i=id-1;
    const upper=Math.min(cap,max[i]),range=min[i]===upper?String(min[i]):min[i]+'–'+upper;
    assert.equal(tile.text,String.fromCodePoint(0xE600+id*8+strip));assert.equal(tile.font,'card:game_icons');
    assert.equal(tile.color,'white');assert.equal(tile.shadow_color,0);
    assert.equal(tile.click_event.action,'run_command');assert.equal(tile.click_event.command,`trigger ct_game_pick set $(p${id})`);
    assert.equal(tile.hover_event.action,'show_text');assert.equal(tile.hover_event.value.text,`${names[i]}（${range}人${ai.has(id)?'+人机':''}）`);
    assert.equal(gap.text,String.fromCodePoint(0xE800+id*8+strip));assert.equal(gap.font,'card:game_icons');assert.equal(gap.click_event,undefined);
    sliceCount++;
   }
   if(strip<7)assert.equal(pieces[offset++].text,'\n');
  }
  assert.equal(offset,pieces.length,'不能混入未验证的图片或点击组件');
 }
 const backup=JSON.parse(fs.readFileSync(`docs/game-icons/picker${cap}-original.json`,'utf8'));
 const ito=backup.actions.find(a=>a.action.command.includes('$(p19)'));
 assert.ok(ito);assert.equal(ito.label.text,`命悬一线（2–${cap}人）`,'原始按钮备份不能把蛛丝副标题重新带回');
 iconCount+=shown.length;
}

const open=read('menu/picker/open'),handle=read('menu/picker/handle'),select=read('menu/select_game');
assert.match(read('system/upgrade_v5'),/objectives add ct_game_pick trigger/);
assert.match(read('load'),/matches 4 run function cardtable:system\/upgrade_v5/);
assert.match(open,/players enable @a\[tag=ct.switch_actor,limit=1\] ct_game_pick/);
assert.equal((open.match(/store result storage cardtable:picker p\d+ int 1/g)||[]).length,count);
assert.match(open,/players add #pick_nonce ct_ctx 100/,'会话步长必须大于全部游戏数');
assert.match(open,/ct_pick_table = @s ct_id/);assert.match(open,/ct_pick_base = #pick_nonce ct_ctx/);
assert.match(read('menu/next_game'),/function cardtable:menu\/picker\/open/);
assert.ok(!read('menu/next_game').includes('players add @s ct_game'));
assert.match(select,/ct_game = #pick_choice ct_ctx run return 0/);
assert.ok(select.indexOf('ct_game = #pick_choice ct_ctx run return 0')<select.indexOf('function cardtable:game/init_selected'));
assert.match(select,/ct_pick_table = #ctx_id ct_ctx run scoreboard players reset @s ct_pick_table/);
assert.match(select,/matches 16 unless score @s ct_capacity matches 8 run return 0/);
for(const id of ids){
 assert.ok(select.includes('ct_game matches '+id+' run tellraw'));
 assert.match(open,new RegExp('operation #pick_button ct_ctx = #pick_nonce ct_ctx\\nscoreboard players add #pick_button ct_ctx '+id+'\\nexecute store result storage cardtable:picker p'+id+' int'));
}
assert.ok(!/matches 19 run return run function cardtable:menu\/picker\/invalid/.test(handle),'19号命悬一线已注册');
const guards=handle.split('\n').filter(l=>l.startsWith('execute unless')&&!l.includes('ct.switch_controller'));
assert.equal(guards.length,3);
function accepted(player,submitted,base,table,current,state,exists,capacity=8){
 const choice=submitted-base;
 for(const guard of guards){
  let ok;
  if(guard.includes('entity @s[tag=ct.player]'))ok=player;
  else if(guard.includes('ct_pick_table = @s ct_id'))ok=table!==undefined&&table===current;
  else if(guard.includes('#pick_choice ct_ctx matches 1..'+highest))ok=Number.isInteger(choice)&&choice>=1&&choice<=highest;
  else throw Error(guard);
  if(!ok)return false;
 }
 return ids.includes(choice)&&exists&&state===0&&(capacity===8||choice!==16);
}
let checks=0;
for(const base of [10,100,200,1000,1999999900])for(const game of ids){
 assert.ok(accepted(true,base+game,base,12,12,0,true));
 for(const args of [[false,base+game,base,12,12,0,true],[true,base+game,base,12,13,0,true],
  [true,base+game,base,undefined,12,0,true],[true,base+game,base,12,12,1,true],
  [true,base+game,base,12,12,0,false],[true,base+game,base+100,12,12,0,true],[true,base+game,base-100,12,12,0,true]])assert.equal(accepted(...args),false);
 checks+=8;
}
for(const base of [100,200,1000]){
 assert.equal(accepted(true,base+19,base,12,12,0,true),true);
 assert.equal(accepted(true,base+16,base,12,12,0,true,4),false);
 for(const invalid of [0,highest+1,-1])assert.equal(accepted(true,base+invalid,base,12,12,0,true),false);
}
assert.match(handle,/scores=\{ct_state=0\}.*ct_id = #pick_table ct_ctx/);
assert.ok(handle.indexOf('reset @s ct_game_pick')<handle.indexOf('menu/select_game'));
for(const f of ['load','seat/remove_player','game/start'])assert.ok(read(f).includes('reset')&&read(f).includes('ct_pick_table'));
assert.ok(read('tick').includes('scores={ct_game_pick=1..}'));
console.log(`通过：${iconCount}个游戏图标、${sliceCount}个可点切片，${count}张PNG/字体映射/透明边界字距、人数与人机提示，${checks}种提交与过期窗口情形。客户端外观与真人点击仍待实测。`);
