import fs from 'node:fs';
import zlib from 'node:zlib';
import assert from 'node:assert/strict';

// 保留原结构的方块调色板和数据版本，仅把中央行、列各扩展一格。
export function decodeNBT(buffer) {
  let pos = 0;
  const byte = () => buffer.readUInt8(pos++);
  const int = () => { const n = buffer.readInt32BE(pos); pos += 4; return n; };
  const str = () => { const n = buffer.readUInt16BE(pos); pos += 2; const s = buffer.toString('utf8', pos, pos+n); pos += n; return s; };
  function payload(type) {
    if (type === 3) return int();
    if (type === 8) return str();
    if (type === 9) { const element = byte(), n = int(); return {element, items:Array.from({length:n}, () => payload(element))}; }
    if (type === 10) { const value = {}; for (let t; (t=byte()) !== 0;) { const name = str(); value[name] = {type:t,value:payload(t)}; } return value; }
    throw new Error('结构含未支持的NBT类型：'+type);
  }
  const type = byte(), name = str(), value = payload(type);
  assert.equal(pos,buffer.length);
  return {type,name,value};
}

export function encodeNBT(root) {
  const parts = [];
  const byte = n => parts.push(Buffer.from([n]));
  const int = n => { const b=Buffer.alloc(4); b.writeInt32BE(n); parts.push(b); };
  const str = s => { const b=Buffer.from(s,'utf8'), h=Buffer.alloc(2); h.writeUInt16BE(b.length); parts.push(h,b); };
  function payload(type,value) {
    if (type===3) return int(value);
    if (type===8) return str(value);
    if (type===9) { byte(value.element); int(value.items.length); for(const item of value.items)payload(value.element,item); return; }
    if (type===10) { for(const [name,tag]of Object.entries(value)){byte(tag.type);str(name);payload(tag.type,tag.value);} byte(0); return; }
    throw new Error('结构含未支持的NBT类型：'+type);
  }
  byte(root.type);str(root.name);payload(root.type,root.value);
  return Buffer.concat(parts);
}

export function makeTable8(table4) {
  assert.deepEqual(table4.value.size.value.items,[5,1,5]);
  const table8=structuredClone(table4);
  table8.value.size.value.items=[6,1,6];
  table8.value.blocks.value.items=[];
  const palette=table8.value.palette.value.items;
  const air=palette.findIndex(p=>p.Name.value==='minecraft:air');
  assert.ok(air>=0);
  const expanded=n=>n===2?[2,3]:[n>2?n+1:n];
  for(const block of table4.value.blocks.value.items) {
    const [x,y,z]=block.pos.value.items;
    for(const xx of expanded(x))for(const zz of expanded(z)) {
      const copy=structuredClone(block);
      copy.pos.value.items=[xx,y,zz];
      // 椅子由block_display生成，结构不再放置真实楼梯。
      if(palette[copy.state.value].Name.value==='minecraft:birch_stairs')copy.state.value=air;
      table8.value.blocks.value.items.push(copy);
    }
  }
  return table8;
}

if (process.argv[1]?.replaceAll('\\','/').endsWith('/generate_table8.mjs')) {
  const table4=decodeNBT(zlib.gunzipSync(fs.readFileSync('data/cardtable/structure/table4.nbt')));
  const table8=makeTable8(table4);
  fs.writeFileSync('data/cardtable/structure/table8.nbt',zlib.gzipSync(encodeNBT(table8)));
  console.log('已生成table8.nbt：4×4桌面，外围保留空气；8张座椅由方块展示实体生成。');
}
