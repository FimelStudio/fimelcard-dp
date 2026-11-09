"""Trim the BMP negative-width fallback; preserve CJK and referenced game glyphs."""
from pathlib import Path
import json, re, gzip, hashlib
ROOT=Path(__file__).resolve().parents[1]
RP=ROOT.resolve().parents[3]/'resourcepacks'
RANGES=[(0x20,0x024f),(0x2000,0x2bff),(0x2e80,0x303f),(0x31c0,0x31ef),(0x3400,0x9fff),(0xf900,0xfaff),(0xfe00,0xfe6f),(0xff00,0xffef)]
def build():
    used=set('\n\r\t')
    for p in ROOT.joinpath('data').rglob('*'):
        if p.suffix not in ('.json','.mcfunction'):continue
        s=p.read_text(encoding='utf-8-sig')
        used.update(s)
        used.update(chr(int(x,16)) for x in re.findall(r'\\u([0-9a-fA-F]{4})',s))
    # Explicit custom glyphs and displacement characters must retain their widths.
    for root in [RP/'fimelcard-rp',RP/'Fimel桌游馆']:
        for p in root.glob('assets/*/font/**/*.json'):
            if p.name=='unifont_neg.json':continue
            d=json.loads(p.read_text(encoding='utf-8-sig'))
            for provider in d.get('providers',[]):
                for row in provider.get('chars',[]):used.update(row)
                used.update(provider.get('advances',{}))
    reports=[]
    for name in ('fimelcard-rp','Fimel桌游馆'):
        p=RP/name/'assets/minecraft/font/include/unifont_neg.json'
        backup=ROOT/'tools/font_backups'/f'{name}_unifont_neg.json.gz'
        backup.parent.mkdir(parents=True,exist_ok=True)
        if not backup.exists():backup.write_bytes(gzip.compress(p.read_bytes()))
        raw=gzip.decompress(backup.read_bytes())
        original=json.loads(raw.decode('utf-8-sig'))
        d=json.loads(raw.decode('utf-8-sig'))
        before=after=0
        for provider in d['providers']:
            if provider.get('type')!='space':continue
            old=provider['advances'];before+=len(old)
            provider['advances']={c:v for c,v in old.items() if c in used or any(a<=ord(c)<=b for a,b in RANGES)}
            after+=len(provider['advances'])
            assert all(old[c]==v for c,v in provider['advances'].items())
            assert (set(old)&used)<=set(provider['advances'])
        data=(json.dumps(d,ensure_ascii=True,separators=(',',':'))+'\n').encode('utf-8')
        p.write_bytes(data)
        reports.append(dict(pack=name,before=before,after=after,removed=before-after,bytes_before=len(raw),bytes_after=len(data),backup=str(backup),sha256=hashlib.sha256(data).hexdigest()))
    report=ROOT/'tools/font_backups/trim_report.json'
    report.write_text(json.dumps(reports,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    for x in reports:print(x['pack'],x['before'],'->',x['after'],'entries;',x['bytes_before'],'->',x['bytes_after'],'bytes')
if __name__=='__main__':build()
