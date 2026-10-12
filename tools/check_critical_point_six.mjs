import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('data/critical_point/function/'+n+'.mcfunction','utf8');
const start=read('game/start'),names=read('dialog/prepare_names'),resolve=read('vote/resolve');
assert.equal((start.match(/ct_joined matches 3\.\.6/g)||[]).length,2);
assert.equal((start.match(/sort=random,limit=1\] add cp.wolf/g)||[]).length,1);
assert.match(start,/cp_threshold = @s ct_joined/);
assert.match(start,/cp_threshold \*= #three cp_ctx/);
const factor=+read('system/install').match(/set #three cp_ctx (\d+)/)[1];
const extra=+start.match(/add @s cp_threshold (\d+)/)[1];
assert.deepEqual([3,4,5,6].map(n=>n*factor+extra),[11,14,17,20]);
assert.match(names,/type:"minecraft:multi_action"/);
assert.ok(!names.includes('空座位'));
assert.match(read('dialog/append_option'),/function hanabi:name\/resolve/);
assert.match(read('dialog/add_option'),/label:\$\(label\)/);
assert.match(read('dialog/show_vote'),/\$dialog show @s \$\(ui\)/);
assert.match(read('vote/handle'),/matches 1\.\.8/);
assert.match(read('vote/handle'),/cp_seat = #target cp_ctx run return 0/);
assert.match(read('vote/handle'),/cp_id = #ctx cp_ctx if score @s cp_seat = #target/);
assert.match(read('system/maintenance'),/#expected cp_ctx = @s cp_threshold/);
assert.match(read('system/maintenance'),/#expected cp_ctx \/= #three cp_ctx/);
assert.match(read('system/maintenance'),/unless score #online cp_ctx = #expected cp_ctx run function critical_point:game\/abort/);
const listed=[...names.matchAll(/scores=\{cp_seat=(\d)\}.*cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat.*append_option/g)].map(m=>+m[1]);
assert.deepEqual(listed,[1,2,3,4,5,6,7,8]);
let layouts=0,menus=0;
for(let mask=1;mask<256;mask++){
 const seated=listed.filter(n=>mask&(1<<(n-1)));
 if(seated.length<3||seated.length>6)continue;
 for(const viewer of seated){assert.deepEqual(listed.filter(n=>seated.includes(n)&&n!==viewer),seated.filter(n=>n!==viewer));menus++;}
 layouts++;
}
// 编译实际计票源码的记分和条件指令，保留玩家归属筛选；聊天与显示不参与数值模拟。
const get=(env,self,who,obj)=>who==='@s'?self[obj]:env.s[who];
const match=(v,r)=>v!==undefined&&(r.includes('..')?v>=+(r.split('..')[0]||'-Infinity')&&v<=+(r.split('..')[1]||'Infinity'):v===+r);
function compile(line){
 if(!line||line.startsWith('#')||line.startsWith('tellraw ')||line.startsWith('tag ')||line.includes('run tellraw '))return ()=>{};
 if(line==='function critical_point:player/mark_audience')return ()=>{};
 let m;
 if((m=line.match(/^function critical_point:game\/finish_(wolf|villagers)$/)))return env=>env.result.push(m[1]);
 if(line.startsWith('execute ')){
  const split=line.indexOf(' run '),action=compile(line.slice(split+5)),conditions=[];
  let prefix=line.slice(8,split);
  while(prefix){
   let c;
   if((c=prefix.match(/^as (\S+)(?: |$)/))){
    const selector=c[1],vote=selector.match(/cp_vote=(\d+)/)?.[1],wolf=selector.includes('tag=cp.wolf');
    conditions.push((env,contexts)=>contexts.flatMap(()=>env.players.filter(p=>(vote===undefined||p.cp_vote===+vote)&&(!wolf||p.wolf))));
   }else if((c=prefix.match(/^(if|unless) score (\S+) (\S+) matches (\S+)(?: |$)/))){
    const [,kind,who,obj,r]=c;conditions.push((env,contexts)=>contexts.filter(self=>match(get(env,self,who,obj),r)===(kind==='if')));
   }else if((c=prefix.match(/^(if|unless) score (\S+) (\S+) (=|>) (\S+) (\S+)(?: |$)/))){
    const [,kind,a,ao,op,b,bo]=c;conditions.push((env,contexts)=>contexts.filter(self=>{
     const x=get(env,self,a,ao),y=get(env,self,b,bo);return (x!==undefined&&y!==undefined&&(op==='='?x===y:x>y))===(kind==='if');
    }));
   }else throw Error(prefix);
   prefix=prefix.slice(c[0].length);
  }
  return (env,self)=>{let contexts=[self];for(const condition of conditions)contexts=condition(env,contexts);for(const context of contexts)action(env,context);};
 }
 if((m=line.match(/^scoreboard players (set|add) (\S+) (\S+) (\d+)$/))){
  const [,op,key,,value]=m;assert.notEqual(key,'@s');return env=>env.s[key]=op==='set'?+value:(env.s[key]||0)+(+value);
 }
 if((m=line.match(/^scoreboard players operation (\S+) (\S+) = (\S+) (\S+)$/))){
  const [,dest,,from,obj]=m;return (env,self)=>env.s[dest]=get(env,self,from,obj);
 }
 throw Error('未覆盖指令：'+line);
}
const program=resolve.split(/\r?\n/).map(compile);
const arrangements=[[1,4,8],[1,3,6,8],[1,3,5,7,8],[1,3,4,6,7,8]];
let ballots=0,wins=0,ties=0,checks=0;
for(const seats of arrangements){
 const count=seats.length,options=seats.map(s=>seats.filter(t=>t!==s));
 const total=(count-1)**count;
 for(let code=0;code<total;code++){
  let remainder=code;
  const players=seats.map((seat,i)=>{const cp_vote=options[i][remainder%(count-1)];remainder=Math.floor(remainder/(count-1));return {cp_seat:seat,cp_vote,cp_id:1};});
  const counts=new Map(seats.map(seat=>[seat,players.filter(p=>p.cp_vote===seat).length]));
  const maximum=Math.max(...counts.values()),leaders=seats.filter(s=>counts.get(s)===maximum);
  for(const wolf of seats){
   const env={s:{},result:[],players:[...players.map(p=>({...p,wolf:p.cp_seat===wolf})),{cp_id:2,cp_seat:8,cp_vote:8,wolf:true}]};
   for(const step of program)step(env,{cp_id:1});
   const expected=leaders.length===1&&leaders[0]===wolf?'villagers':'wolf';
   assert.deepEqual(env.result,[expected]);assert.equal(env.s['#leaders'],leaders.length);
   for(const seat of seats)assert.equal(env.s['#v'+seat],counts.get(seat));
   if(expected==='villagers')wins++;if(leaders.length>1)ties++;checks++;
  }
  ballots++;
 }
}
assert.ok(wins>0&&ties>0);
for(const n of ['round/check_all','round/check_ready','vote/check_all'])assert.ok(read(n).includes('= @s ct_joined'));
assert.match(read('round/reveal'),/cp_round matches 5 run function critical_point:game\/finish_villagers/);
assert.match(read('round/reveal'),/if score #sum cp_ctx > @s cp_threshold run function critical_point:vote\/start/);
assert.ok(!read('load').includes('game/abort'));
console.log('通过：'+layouts+'种3至6人稀疏座位、'+menus+'份投票菜单、5/6人安全线及人数限制。');
console.log('通过：根据实际计票指令验证'+ballots+'种完整选票、'+checks+'次身份与胜负组合，含高号座狼人、平票、双桌隔离及离线维护。');
console.log('以上为静态与指令模型检查，尚未Minecraft联机实测。');
