import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=(ns,n)=>fs.readFileSync('data/'+ns+'/function/'+n+'.mcfunction','utf8');
const source=read('cardtable','vote/count');
function count(cap,players){
 const table={ct_id:12,ct_capacity:cap,ct_votes:99},scores={};
 const get=(who,obj,self)=>who==='@s'?self[obj]:scores[who];
 const set=(who,obj,n,self)=>{if(who==='@s')self[obj]=n;else scores[who]=n;};
 function run(line,self){
  if(!line||line.startsWith('#'))return;
  let m;
  if(line.startsWith('execute ')){
   const at=line.indexOf(' run '),body=line.slice(at+5);let prefix=line.slice(8,at),contexts=[self];
   while(prefix){
    if((m=prefix.match(/^as (@a\[[^\]]+\])(?: |$)/)))contexts=contexts.flatMap(()=>players.filter(p=>p.member&&(!m[1].includes('ct_voted=1')||p.ct_voted===1)));
    else if((m=prefix.match(/^if score (\S+) (\S+) = (\S+) (\S+)(?: |$)/)))contexts=contexts.filter(c=>get(m[1],m[2],c)===get(m[3],m[4],c));
    else if((m=prefix.match(/^if score (\S+) (\S+) matches (\S+)(?: |$)/)))contexts=contexts.filter(c=>{const v=get(m[1],m[2],c),r=m[3];return r.includes('..')?v>=Number(r.split('..')[0]||-Infinity)&&v<=Number(r.split('..')[1]||Infinity):v===Number(r);});
    else throw Error(prefix);
    prefix=prefix.slice(m[0].length);
   }
   for(const c of contexts)run(body,c);return;
  }
  if((m=line.match(/^scoreboard players (set|add) (\S+) (\S+) (\d+)$/))){set(m[2],m[3],m[1]==='set'?+m[4]:(get(m[2],m[3],self)||0)+Number(m[4]),self);return;}
  if((m=line.match(/^scoreboard players operation (\S+) (\S+) (=|\/=) (\S+) (\S+)$/))){set(m[1],m[2],m[3]==='='?get(m[4],m[5],self):Math.floor(get(m[1],m[2],self)/get(m[4],m[5],self)),self);return;}
  throw Error(line);
 }
 for(const line of source.split(/\r?\n/))run(line,table);
 return {votes:table.ct_votes,need:scores['#vote_need'],players:scores['#vote_players']};
}
let cases=0;
for(const cap of [4,8])for(let n=0;n<=cap;n++)for(let mask=0;mask<2**n;mask++){
 const players=Array.from({length:n},(_,i)=>({ct_id:12,ct_voted:(mask>>i)&1,member:true}));
 players.push({ct_id:13,ct_voted:1,member:true},{ct_id:12,ct_voted:1,member:false});
 const result=count(cap,players);
 assert.deepEqual(result,{players:n,votes:[...Array(n).keys()].filter(i=>mask&(1<<i)).length,need:cap===8?Math.floor(n/2)+1:Math.max(1,Math.min(3,n))});cases++;
}
const remaining=[{ct_id:12,ct_voted:1,member:true},{ct_id:12,ct_voted:1,member:true},{ct_id:12,ct_voted:0,member:true}];
assert.deepEqual(count(8,remaining),{votes:2,need:2,players:3});
remaining[1].member=false;assert.deepEqual(count(8,remaining),{votes:1,need:2,players:2});
assert.match(read('cardtable','table/recount_players'),/ct_state matches 1 run function cardtable:vote\/refresh/);
assert.match(read('cardtable','vote/refresh'),/#vote_players ct_ctx matches 1\.\. if score @s ct_votes >= #vote_need ct_ctx run return run function cardtable:vote\/finish/);
for(let game=1;game<=10;game++)assert.ok(read('cardtable','vote/finish').includes('ct_game matches '+game+' run return run function'));
for(const [ns,prefix]of [['wenfei','wq'],['skull','sk']]){
 const scan=read(ns,'input/scan'),drop=read(ns,'input/drop');
 assert.match(scan,new RegExp('as @a\\[tag='+prefix+'\\.player,tag=ct.player\\].*ct_id = @s '+prefix+'_id at @s as @e'));
 assert.match(drop,/execute on origin.*at @s run function/);
 assert.ok(drop.includes('run return 0'),'保留物品桌号校验');
 for(const distance of [0,9,100,10000])assert.ok(Math.abs((distance+1)-distance)<=8,'扫描中心是玩家，不是桌子');
}
assert.match(read('cardtable','admin/create8'),/execute align xyz summon minecraft:marker/,'用户要求暂不修改中心');
console.log('通过：'+cases+'种实际投票计数、玩家离桌后门槛/旧票重算、10游戏结束分派、远离牌桌的道具扫描及桌号/丢出者校验。');
