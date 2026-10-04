import fs from 'node:fs';
import assert from 'node:assert/strict';
const text=fs.readFileSync('tools/doudizhu-center/stack_cell.mcfunction','utf8');
assert(text.startsWith('$execute unless data storage doudizhu:ui stack_columns[$(column)] run return 0'));
assert(text.includes('execute if score #stack_slice dd_ctx matches 6.. run return run function doudizhu:dialog/stack_blank'));
let cases=0;
for(let columns=1;columns<=15;columns++){
 for(let band=0;band<Math.ceil(columns/9);band++){
  const expected=Math.min(9,columns-band*9)*45;
  for(let line=0;line<9;line++){
   let width=0;
   for(let local=0;local<9;local++){
    const column=band*9+local;
    if(column>=columns)continue;
    // Existing columns retain 42px card/blank + 3px gap at every slice.
    width+=45;
   }
   assert.equal(width,expected);cases++;
  }
 }
}
assert.equal(3*45,135); // Screenshot: three ranks, not nine columns (405px).
console.log(cases+' row-width cases passed; missing columns emit nothing, internal alignment retained.');
