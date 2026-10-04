import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('tools/doudizhu-stack/'+n+'.mcfunction','utf8');
assert(read('hand/append').includes('rank:$(rank)'));
assert(read('hand/append').includes('card:doudizhu/stack_selected'));
assert(read('dialog/stack_cell').includes('#stack_index dd_ctx < #stack_count dd_ctx'));
assert(read('dialog/stack_cell').includes('#stack_slice dd_ctx matches 6..'));
assert(read('dialog/stack_fragment').includes('cards[$(index)].action.command'));
assert(!read('dialog/stack_blank').includes('click_event'));
let checks=0;
for(let count=1;count<=4;count++){
 const visible=Array.from({length:count},()=>[]);
 for(let line=0;line<9;line++){
  const index=Math.min(line,count-1),slice=line-index;
  if(slice<6)visible[index].push(slice);
 }
 for(let i=0;i<count;i++){
  assert.deepEqual(visible[i],i===count-1?[0,1,2,3,4,5]:[0]);checks++;
 }
}
for(const variant of ['stack','stack_selected']){
 const f=JSON.parse(fs.readFileSync('../fimelcard-rp/assets/card/font/doudizhu/'+variant+'.json'));
 const p=f.providers[0];assert.equal(p.height,9);assert.equal(p.chars.length,36);
 assert.equal(new Set(p.chars.join('')).size,324);
 for(let card=0;card<54;card++)for(let slice=0;slice<6;slice++){
  assert.equal(p.chars[Math.floor(card/9)*6+slice][card%9].charCodeAt(0),0xe200+card*8+slice);
 }
}
assert(9*(42+3)<440);
assert(!read('dialog/grid').includes('card:doudizhu/spacing'));
console.log('54张牌×6切片、普通/选中字体映射、1～4张堆叠点击归属及九列宽度检查通过。');
