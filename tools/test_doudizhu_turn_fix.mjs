import fs from 'node:fs';
import assert from 'node:assert/strict';
const base=new URL('./doudizhu-turn-fix/doudizhu/function/',import.meta.url);
const read=p=>fs.readFileSync(new URL(p+'.mcfunction',base),'utf8');
const advance=read('round/advance'),wrap=read('round/wrap');
function runTurn(order,turn){
 let next=+advance.match(/set #next dd_ctx (\d+)/)[1];
 const operation=advance.match(/run scoreboard players operation #next dd_ctx ([=<]) @s dd_seat/)[1];
 const forks=order.filter(s=>s>turn);
 for(const s of forks)next=operation==='<'?Math.min(next,s):s;
 if(next===9){const op=wrap.match(/operation #next dd_ctx ([=<]) @s dd_seat/)[1];for(const s of order)next=op==='<'?Math.min(next,s):s;}
 return next;
}
let checks=0;
for(let a=1;a<=6;a++)for(let b=a+1;b<=7;b++)for(let c=b+1;c<=8;c++){
 const seats=[a,b,c];
 for(const order of [[a,b,c],[a,c,b],[b,a,c],[b,c,a],[c,a,b],[c,b,a]])for(let i=0;i<3;i++){
   assert.equal(runTurn(order,seats[i]),seats[(i+1)%3],JSON.stringify({order,turn:seats[i]}));checks++;
 }
}
const handler=read('action/handle');
assert(handler.startsWith('scoreboard players set #submitted dd_ctx 0'));
for(const [submitted,shouldOpen,shouldClose]of [[0,true,false],[1,false,true]]){
 const commands=handler.split('\n').filter(l=>l.includes('if entity @s[tag=dd.player] if score #submitted'));
 const executed=commands.filter(l=>+l.match(/matches (\d+)/)[1]===submitted);
 assert.equal(executed.some(l=>l.endsWith('function doudizhu:dialog/open')),shouldOpen);
 assert.equal(executed.some(l=>l.endsWith('dialog clear @s')),shouldClose);
}
for(const name of ['action/play','action/pass','bid/submit']){
 const text=read(name),accepted=text.indexOf('scoreboard players set #submitted dd_ctx 1');
 assert(accepted>text.indexOf('dd_turn run return'),name+'必须先检查轮次');
 assert(accepted<text.indexOf('function doudizhu:round/advance'),name+'必须在切换轮次前标记成功');
}
assert(read('action/play').indexOf('#submitted dd_ctx 1')>read('action/play').indexOf('unless score #beats dd_ctx matches 1 run return 0'));
assert(read('action/pass').indexOf('#submitted dd_ctx 1')>read('action/pass').indexOf('dd_type matches 0 run return 0'));
assert(read('bid/submit').indexOf('#submitted dd_ctx 1')>read('bid/submit').indexOf('dd_bid run return 0'));
console.log(`${checks}项座位顺序回归检查通过；确认关闭、选牌保留及无效提交保留检查通过。`);
