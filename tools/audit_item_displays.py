"""检查资源引用，并从实际发放指令定位缺少手持姿态的横放模型。"""
import argparse
import json
import math
import re
import subprocess
from collections import Counter
from pathlib import Path

PACK=Path(__file__).resolve().parents[1]
RP=PACK.parents[3]/'resourcepacks/fimelcard-rp'
CONTEXTS=('gui','firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand','ground')


def audit():
    definitions={}
    models={}
    for namespace in (RP/'assets').iterdir():
        if not namespace.is_dir():continue
        for kind,registry in (('items',definitions),('models',models)):
            root=namespace/kind
            for path in root.rglob('*.json'):
                registry[namespace.name+':'+path.relative_to(root).with_suffix('').as_posix()]=json.loads(path.read_text(encoding='utf-8-sig'))
    errors=[]
    def model_refs(node):
        if isinstance(node,dict):
            if node.get('type')=='minecraft:model' and isinstance(node.get('model'),str):
                yield node['model']
            for value in node.values():yield from model_refs(value)
        elif isinstance(node,list):
            for value in node:yield from model_refs(value)
    rendered=set()
    for name,definition in definitions.items():
        for ref in model_refs(definition):
            rendered.add(ref)
            if not ref.startswith('minecraft:') and ref not in models:
                errors.append({'item':name,'missing_model':ref})
    for name,body in models.items():
        parent=body.get('parent','')
        if parent and not parent.startswith(('minecraft:','builtin/')) and parent not in models:
            errors.append({'model':name,'missing_parent':parent})
    handed={}
    unresolved=[]
    kinds={}
    assigned_models={}
    raw=subprocess.check_output(['rg','-n','minecraft:item_model','data','-g','*.mcfunction'],cwd=PACK).decode('utf-8')
    for line in raw.splitlines():
        if not re.search(r'\b(?:give |item replace entity )',line):continue
        for ref in re.findall(r'(?:"minecraft:item_model"|minecraft:item_model)\s*[:=]\s*"([^"]+)"',line):
            if ref.startswith('minecraft:'):continue
            if '$(model)' in ref or ('$(' in ref and '/' not in ref.split('$(',1)[0]):
                source=line.split(':',2)[0]
                namespace=Path(source).parts[1]
                if namespace not in assigned_models:
                    result=subprocess.run(['rg','model','data/'+namespace,'-g','*.mcfunction'],cwd=PACK,capture_output=True)
                    assigned_models[namespace]=set(re.findall(r'(?:"model"|\bmodel)\s*(?:set value\s+|:\s*)"([^"]+)"',result.stdout.decode('utf-8')))
                candidates=set()
                for value in assigned_models[namespace]:
                    expanded=ref.replace('$(model)',value)
                    pattern='^'+''.join(r'[^/]+' if part.startswith('$(') else re.escape(part) for part in re.split(r'(\$\([^)]*\))',expanded))+'$'
                    candidates.update(name for name in definitions if re.fullmatch(pattern,name))
                for name in candidates:handed.setdefault(name,set()).add(source)
                unresolved.append({'source':source,'template':ref,'assigned_candidates':len(candidates)})
                continue
            namespace=Path(line.split(':',2)[0]).parts[1]
            if '$(kind)' in ref and namespace not in kinds:
                result=subprocess.run(['rg','-o',r'kind set value "[^"]+"','data/'+namespace,'-g','*.mcfunction'],cwd=PACK,capture_output=True)
                kinds[namespace]=sorted(set(re.findall(r'kind set value "([^"]+)"',result.stdout.decode('utf-8'))))
            def part_pattern(part):
                if part=='$(kind)' and kinds.get(namespace):return '(?:'+'|'.join(map(re.escape,kinds[namespace]))+')'
                if part in ('$(number)','$(rank)','$(id)'):return r'\d+'
                return r'[^/]+' if part.startswith('$(') else re.escape(part)
            pattern='^'+''.join(map(part_pattern,re.split(r'(\$\([^)]*\))',ref)))+'$'
            matches=[name for name in definitions if re.fullmatch(pattern,name)]
            if not matches and '$(' not in ref:
                errors.append({'source':line.split(':',2)[0],'missing_item':ref})
            for name in matches:handed.setdefault(name,set()).add(line.split(':',2)[0])
    def resolve(node,context):
        if not isinstance(node,dict):return []
        if node.get('type')=='minecraft:model':return [node['model']]
        if node.get('type')=='minecraft:select' and node.get('property')=='minecraft:display_context':
            for case in node.get('cases',[]):
                when=case.get('when',[])
                if context in ([when] if isinstance(when,str) else when):return resolve(case['model'],context)
            return resolve(node.get('fallback'),context)
        return list(model_refs(node))
    def inherited(name,seen=None):
        seen=set() if seen is None else seen
        if name in seen:return {}
        seen.add(name)
        body=models.get(name,{})
        parent=inherited(body.get('parent'),seen) if body.get('parent') in models else {}
        return {**parent,**body,'display':{**parent.get('display',{}),**body.get('display',{})},
                'textures':{**parent.get('textures',{}),**body.get('textures',{})}}
    texture_count=0
    for name in models:
        body=inherited(name)
        textures=body.get('textures',{})
        for key,ref in textures.items():
            seen=set()
            while ref.startswith('#') and ref[1:] in textures and ref not in seen:
                seen.add(ref);ref=textures[ref[1:]]
            if ref.startswith('#') and name in rendered:
                errors.append({'model':name,'unresolved_texture':ref})
            elif ':' in ref and not ref.startswith('minecraft:'):
                namespace,location=ref.split(':',1)
                texture_count+=1
                if not (RP/f'assets/{namespace}/textures/{location}.png').is_file():
                    errors.append({'model':name,'missing_texture':ref})
        for element in body.get('elements',[]):
            for face in element.get('faces',{}).values():
                ref=face.get('texture','')
                if name in rendered and ref.startswith('#') and ref[1:] not in textures:
                    errors.append({'model':name,'unresolved_face_texture':ref})
    findings=[]
    for item,sources in sorted(handed.items()):
        for context in CONTEXTS[1:5]:
            for ref in resolve(definitions[item].get('model'),context):
                body=inherited(ref)
                elements=body.get('elements',[])
                if not elements:continue
                bounds=[max(e['to'][axis] for e in elements)-min(e['from'][axis] for e in elements) for axis in range(3)]
                display=body.get('display',{})
                pose=display.get(context,display.get(context.replace('lefthand','righthand'),{}))
                if bounds[1]<=2 and bounds[2]>=8 and not pose:
                    findings.append({'item':item,'context':context,'model':ref,'finding':'flat_model_without_hand_pose','sources':sorted(sources)})
                elif context.startswith('firstperson_') and max(bounds)>0:
                    axis=min(range(3),key=lambda i:bounds[i])
                    if bounds[axis]/max(bounds)<.15:
                        normal=[0,0,0];normal[axis]=1
                        for rotation_axis,degrees in enumerate(pose.get('rotation',[0,0,0])):
                            angle=math.radians(degrees);c=math.cos(angle);v=math.sin(angle)
                            x,y,z=normal
                            normal=([x,y*c-z*v,y*v+z*c] if rotation_axis==0 else
                                    [x*c+z*v,y,-x*v+z*c] if rotation_axis==1 else
                                    [x*c-y*v,x*v+y*c,z])
                        if abs(normal[2])<.12:
                            findings.append({'item':item,'context':context,'model':ref,'finding':'potential_edge_on_hand_pose','sources':sorted(sources)})
                if context.startswith('firstperson_') and max(v*s for v,s in zip(bounds,pose.get('scale',[1,1,1])))>20:
                    findings.append({'item':item,'context':context,'model':ref,'finding':'potential_oversized_hand_pose','sources':sorted(sources)})
    return {'definitions':len(definitions),'models':len(models),'texture_references':texture_count,'handed_items':len(handed),
            'reference_errors':len(errors),'hand_findings':len(findings),'errors':errors,'findings':findings,
            'generic_hand_templates':unresolved,
            'finding_groups':dict(Counter('/'.join(row['model'].split('/')[:3]) for row in findings))}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path)
    parser.add_argument('--fail-on-hand-issues',action='store_true')
    args=parser.parse_args()
    report=audit()
    if args.output:args.output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({key:value for key,value in report.items() if key not in ('errors','findings','generic_hand_templates')},ensure_ascii=False))
    for row in report['errors'][:20]:print(json.dumps(row,ensure_ascii=False))
    raise SystemExit(bool(report['errors'] or (args.fail_on_hand_issues and report['findings'])))
