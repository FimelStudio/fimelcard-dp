import json, pathlib, zipfile, hashlib
root=pathlib.Path(r'C:/Users/Chen Yuru/AppData/Roaming/.minecraft/versions/26.2-Fabric 0.19.3/resourcepacks')
names=['Pool-Resourcepack-Squid-Workshop-1.21plus','NyaaWorks喵工坊-r2.2-fixed','fimelcard-rp']
assets={}; owners={}; merged=[]; originals={}
for name in names:
    base=root/name
    files={p.relative_to(base).as_posix():p for p in base.rglob('*') if p.is_file()}
    originals[name]=json.loads((base/'pack.mcmeta').read_text(encoding='utf-8-sig'))
    effective={k:p for k,p in files.items() if k.startswith('assets/')}
    # Flatten only overlays enabled for resource format 88 (Java 26.2).
    for entry in originals[name].get('overlays',{}).get('entries',[]):
        fmt=entry.get('formats'); lo=entry.get('min_format'); hi=entry.get('max_format')
        if lo is None:
            if isinstance(fmt,list):lo,hi=fmt
            elif isinstance(fmt,dict):lo,hi=fmt['min_inclusive'],fmt['max_inclusive']
            else:lo=hi=fmt
        if lo is not None and lo<=88<=hi:
            prefix=entry['directory']+'/'
            effective.update({k[len(prefix):]:p for k,p in files.items() if k.startswith(prefix+'assets/')})
    for key,p in effective.items():
        content=p.read_bytes()
        if key in assets and assets[key]!=content:
            if '/atlases/' not in key:raise RuntimeError('Unresolved collision: '+key)
            a=json.loads(assets[key]);b=json.loads(content)
            for source in b['sources']:
                if source not in a['sources']:a['sources'].append(source)
            content=json.dumps(a,ensure_ascii=False,indent=2).encode('utf-8');merged.append(key)
        assets[key]=content;owners[key]=name
    for key,p in files.items():
        if not key.startswith('assets/') and not any(key.startswith(e['directory']+'/') for e in originals[name].get('overlays',{}).get('entries',[])):
            assets['sources/'+name+'/'+key]=p.read_bytes()
assets['pack.mcmeta']=json.dumps({'pack':{'description':'Fimel Cards × 喵工坊 × Squid Workshop 台球 | 26.2 三合一','min_format':88,'max_format':88}},ensure_ascii=False,indent=2).encode('utf8')
assets['pack.png']=(root/'fimelcard-rp/pack.png').read_bytes()
assets['README-合并说明.txt']=('26.2 三合一资源包\n\n来源：\n- fimelcard-rp：Ylong\n- NyaaWorks喵工坊-r2.2-fixed：原作者署名以 sources 中原始说明为准\n- Pool-Resourcepack-Squid-Workshop-1.21plus：YMS2001 / Squid Workshop\n\n仅面向 Minecraft Java 26.2（资源格式88）。\n将此ZIP放入resourcepacks并启用，无需解压；原来三个资源包可以停用，避免重复覆盖。\n资源包只负责显示和声音，游戏仍需原有数据包或模组。\n已展开26.2启用的喵工坊物品模型覆盖层，不启用旧版本着色器。\n合并方块图集sources，保留牌桌HUD着色器、家具、台球、表情与声音。\n三个原始包未修改，原包元数据及说明位于sources目录。\n').encode('utf8')
assets['merge-manifest.json']=json.dumps({'target_format':88,'sources':names,'merged':merged,'assets':{k:{'source':owners[k],'sha256':hashlib.sha256(v).hexdigest()} for k,v in assets.items() if k in owners}},ensure_ascii=False,indent=2).encode('utf8')
out=pathlib.Path('dist/FimelCard-NyaaWorks-Pool-26.2.zip');out.parent.mkdir(exist_ok=True)
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED,compresslevel=6) as z:
    for key,value in assets.items():z.writestr(key,value)
with zipfile.ZipFile(out) as z:
    assert z.testzip() is None
    assert 'assets/minecraft/items/firework_star.json' in z.namelist()
    assert len(z.namelist())==len(set(z.namelist()))
    errors=[]
    for k in z.namelist():
        if k.endswith('.json') or k.endswith('.mcmeta'):
            try:json.loads(z.read(k).decode('utf-8-sig'))
            except Exception as e:errors.append((k,str(e)))
    print('JSON parse issues:',errors[:15], 'count',len(errors))
print('Archive:',out.resolve(),'files:',len(assets),'bytes:',out.stat().st_size,'merged:',merged)
