# -*- coding: utf-8 -*-
"""Verify sports-track geometry, model closure, 36 glyphs, dice and audio sources."""
import base64
import hashlib
import io
import json
import math
import subprocess
import unittest

from PIL import Image
from boardgame_assets import PACK, RP, CARD

SOURCE=RP/'.source/magical_athlete'
CHARS=json.loads((PACK/'tools/magical_athlete_characters.json').read_text(encoding='utf-8'))
TRACK=json.loads((PACK/'tools/magical_athlete_track.json').read_text(encoding='utf-8'))


class Assets(unittest.TestCase):
    def test_sculptures_have_no_intersecting_cubes_or_duplicate_outer_faces(self):
        for entry in [*CHARS,{'slug':'back'}]:
            slug=entry['slug']
            reference=None
            for kind in ('racer','token','hand'):
                elements=json.loads((CARD/f'models/item/magical_athlete/{kind}/{slug}.json').read_text(encoding='utf-8'))['elements']
                if reference is None:reference=elements
                else:self.assertEqual(elements,reference,(slug,kind))
                for i,a in enumerate(elements):
                    self.assertTrue(1<=len(a['faces'])<=6,(slug,kind,a['name'],'Minecraft rejects elements without faces'))
                    self.assertTrue(all(end>=start for start,end in zip(a['from'],a['to'])),(slug,a['name']))
                    flat=[axis for axis in range(3) if a['from'][axis]==a['to'][axis]]
                    if flat:
                        self.assertEqual(len(flat),1,(slug,a['name']))
                        self.assertEqual(len(a['faces']),1,(slug,a['name']))
                    for b in elements[i+1:]:
                        spans=[min(a['to'][axis],b['to'][axis])-max(a['from'][axis],b['from'][axis]) for axis in range(3)]
                        self.assertFalse(all(span>1e-7 for span in spans),(slug,a['name'],b['name'],'intersecting solids'))
                        for low,up,axis in (('west','east',0),('down','up',1),('north','south',2)):
                            for side1,limit1 in ((low,'from'),(up,'to')):
                                for side2,limit2 in ((low,'from'),(up,'to')):
                                    if side1 not in a['faces'] or side2 not in b['faces']:continue
                                    if abs(a[limit1][axis]-b[limit2][axis])>1e-7:continue
                                    self.assertFalse(all(spans[j]>1e-7 for j in range(3) if j!=axis),(slug,a['name'],b['name'],side1,side2,'overlapping coplanar faces'))

    def test_sculpture_cleanup_preserves_volume_and_decoration_colors(self):
        from build_magical_athlete_figures import sculpt,COLOR_INDEX
        def union_volume(boxes):
            # 独立的扫描线积分，检查布尔切割没有挖洞或增加体积。
            xs=sorted({p[k][0] for p in boxes for k in ('from','to')});total=0
            for x0,x1 in zip(xs,xs[1:]):
                active=[p for p in boxes if p['from'][0]<(x0+x1)/2<p['to'][0]]
                ys=sorted({p[k][1] for p in active for k in ('from','to')});area=0
                for y0,y1 in zip(ys,ys[1:]):
                    zs=sorted((p['from'][2],p['to'][2]) for p in active if p['from'][1]<(y0+y1)/2<p['to'][1])
                    end=-math.inf;length=0
                    for a,b in zs:
                        length+=max(0,b-max(a,end));end=max(end,b)
                    area+=(y1-y0)*length
                total+=(x1-x0)*area
            return total
        for entry in [*CHARS,{'slug':'back'}]:
            slug=entry['slug'];parts=sculpt(slug).parts
            elements=json.loads((CARD/f'models/item/magical_athlete/racer/{slug}.json').read_text(encoding='utf-8'))['elements']
            low=[min(p['from'][i] for p in parts) for i in range(3)]
            high=[max(p['to'][i] for p in parts) for i in range(3)]
            scale=(max(p['to'][0] for p in elements)-min(p['from'][0] for p in elements))/(high[0]-low[0])
            expected=union_volume(parts)*scale**3
            # 用闭合外表面的有向面积积分求体积，允许省略完全不可见的内部方块。
            # 每个面贡献 outward_normal · position * area / 3。
            actual=0
            for part in elements:
                for side in part['faces']:
                    axis={'west':0,'east':0,'down':1,'up':1,'north':2,'south':2}[side]
                    upper=side in ('east','up','south')
                    area=math.prod(part['to'][i]-part['from'][i] for i in range(3) if i!=axis)
                    actual+=(1 if upper else -1)*part['to' if upper else 'from'][axis]*area/3
            self.assertAlmostEqual(actual,expected,delta=expected*2e-6,msg=slug)
            center=[(low[0]+high[0])/2,low[1],(low[2]+high[2])/2]
            for part in elements:
                if not part['faces']:continue
                point=[((part['from'][i]+part['to'][i])/2-8)/scale+center[i] for i in range(3)]
                for axis in range(3):
                    if part['from'][axis]!=part['to'][axis]:continue
                    side=next(iter(part['faces']))
                    point[axis]+=1e-4 if side in ('west','down','north') else -1e-4
                owner=next(p for p in reversed(parts) if all(a-1e-5<x<b+1e-5 for a,x,b in zip(p['from'],point,p['to'])))
                uv=next(iter(part['faces'].values()))['uv'];index=round(uv[1]/2)*8+round(uv[0]/2)
                self.assertEqual(index,COLOR_INDEX[owner['color']],(slug,part['name'],'decoration material'))

    def test_geometry_is_unique_and_fits_table(self):
        points=TRACK['layout']['positions']
        self.assertEqual(len(points),31)
        self.assertEqual(len(set(tuple(p) for p in points)),31)
        self.assertEqual(TRACK['start'],0)
        self.assertEqual(TRACK['finish'],30)
        self.assertEqual(TRACK['second_corner'],15)
        self.assertEqual(points[15],[14,2])
        for a,b in zip(points,points[1:]):
            self.assertGreater(math.dist(a,b),1.4)
            self.assertLess(math.dist(a,b),1.8)
        for x,z in points:
            self.assertTrue(1.2<x<14.8 and 1.2<z<14.8)
        for capacity,foot in ((4,2.7),(8,3.6)):
            self.assertEqual(TRACK['layout']['footprints'][str(capacity)],foot)
            for x,z in points:
                self.assertLess(abs((x-8)*foot/16)+.16,foot/2)
                self.assertLess(abs((z-8)*foot/16)+.16,foot/2)

    def test_all_roles_unique_and_readable(self):
        self.assertEqual([entry['id'] for entry in CHARS],list(range(36)))
        signatures=set()
        for entry in CHARS:
            path=CARD/f"textures/item/magical_athlete/portrait/{entry['slug']}.png"
            with Image.open(path) as image:
                self.assertEqual(image.size,(128,128))
                self.assertEqual(image.mode,'RGBA')
                self.assertIsNotNone(image.getchannel('A').getbbox())
            signatures.add(hashlib.sha256(path.read_bytes()).hexdigest())
            for kind in ('racer','token'):
                self.assertTrue((CARD/f"items/magical_athlete/{kind}/{entry['slug']}.json").exists())
        self.assertEqual(len(signatures),36)
        for folder in (CARD/'textures/item/magical_athlete',SOURCE/'textures'):
            for entry in CHARS:
                self.assertFalse((folder/'racer'/(entry['slug']+'.png')).exists())

    def test_runtime_model_and_editable_source_closure(self):
        paths=list((CARD/'models/item/magical_athlete').rglob('*.json'))
        self.assertGreater(len(paths),90)
        for path in paths:
            body=json.loads(path.read_text(encoding='utf-8'))
            for resource in body.get('textures',{}).values():
                if resource.startswith('#'):continue
                ns,location=resource.split(':',1)
                self.assertTrue((RP/f'assets/{ns}/textures/{location}.png').exists(),resource)
            relative=path.relative_to(CARD/'models/item/magical_athlete')
            item=json.loads((CARD/'items/magical_athlete'/relative).read_text(encoding='utf-8'))
            if relative.as_posix().startswith('hand/') and relative.stem!='back':
                self.assertEqual(item['model']['type'],'minecraft:select')
                self.assertEqual(item['model']['cases'][0]['model']['model'],'card:item/magical_athlete/'+relative.with_suffix('').as_posix())
            else:
                self.assertEqual(item['model']['model'],'card:item/magical_athlete/'+relative.with_suffix('').as_posix())
            source=SOURCE/'models'/relative.with_suffix('.bbmodel')
            self.assertTrue(source.exists(),source)
            editable=json.loads(source.read_text(encoding='utf-8'))
            for texture in editable['textures']:
                image=Image.open(io.BytesIO(base64.b64decode(texture['source'].split(',',1)[1])))
                self.assertEqual(image.size,(texture['width'],texture['height']))
            for part in body.get('elements',[]):
                self.assertEqual(len(part['from']),3)
                self.assertEqual(len(part['to']),3)
                for a,b in zip(part['from'],part['to']):
                    self.assertLessEqual(a,b)
                    self.assertGreaterEqual(a,-16)
                    self.assertLessEqual(b,32)

    def test_3d_figures_fit_hand_and_keep_other_views_private(self):
        signatures=set()
        for entry in [*CHARS,{'slug':'back'}]:
            slug=entry['slug']
            body=json.loads((CARD/f'models/item/magical_athlete/hand/{slug}.json').read_text(encoding='utf-8'))
            geometry=[{'from':e['from'],'to':e['to']} for e in body['elements']]
            if slug!='back':signatures.add(json.dumps(geometry,sort_keys=True))
            self.assertGreaterEqual(len(geometry),7)
            for axis in range(3):
                low=min(e['from'][axis] for e in body['elements'])
                high=max(e['to'][axis] for e in body['elements'])
                self.assertGreater(high-low,3,(slug,axis))
                if axis==1:
                    self.assertEqual(low,8,(slug,'feet must not sink during display scaling'))
                    self.assertLessEqual(high-low,18)
                else:
                    self.assertAlmostEqual((low+high)/2,8,places=6)
                    self.assertLessEqual(high-low,14.000001)
                for context in ('firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand'):
                    self.assertLess((high-low)*body['display'][context]['scale'][axis],6)
            if slug=='back':continue
            item=json.loads((CARD/f'items/magical_athlete/hand/{slug}.json').read_text(encoding='utf-8'))['model']
            for context in ('gui','firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand','ground','head','fixed','none'):
                selected=item['fallback']
                for case in item['cases']:
                    if context in case['when']:
                        selected=case['model'];break
                if context=='gui' or context.startswith('firstperson_'):
                    expected='card:item/magical_athlete/hand/'+slug
                else:
                    expected='card:item/magical_athlete/hand/back'
                self.assertEqual(selected['model'],expected,(slug,context))
        self.assertEqual(len(signatures),36,'Characters must have different geometry, not only different textures')

    def test_fonts_exact_mapping_and_small_glyphs(self):
        body=json.loads((RP/'assets/magical_athlete/font/icons.json').read_text(encoding='utf-8'))
        found={}
        for provider in body['providers']:
            chars=provider['chars'];ns,location=provider['file'].split(':',1)
            with Image.open(RP/f'assets/{ns}/textures/{location}') as image:
                self.assertEqual(image.width%len(chars[0]),0)
                self.assertEqual(image.height%len(chars),0)
                self.assertLessEqual(image.width//len(chars[0]),256)
                self.assertLessEqual(image.height//len(chars),256)
            for line in chars:
                for char in line:
                    self.assertNotIn(char,found)
                    found[char]=provider
        for i in range(36):
            self.assertEqual(found[chr(0xe200+i)]['height'],22)
        for i in range(12):
            self.assertEqual(found[chr(0xe100+i)]['height'],16)
        self.assertEqual(len(found),48)

    def test_dice_faces_and_visible_pips(self):
        die=json.loads((CARD/'models/item/magical_athlete/dice.json').read_text(encoding='utf-8'))
        expected={'up':1,'down':6,'north':2,'south':5,'east':3,'west':4}
        for face,value in expected.items():
            self.assertEqual(die['elements'][0]['faces'][face]['texture'],'#f'+str(value))
        for a,b in (('up','down'),('north','south'),('east','west')):
            self.assertEqual(expected[a]+expected[b],7)

    def test_board_hazards_match_rule_manifest(self):
        with Image.open(CARD/'textures/item/magical_athlete/board/mild.png') as mild,Image.open(CARD/'textures/item/magical_athlete/board/wild.png') as wild:
            self.assertEqual(mild.size,(1536,1536))
            self.assertEqual(wild.size,mild.size)
            for index in TRACK['wild']:
                x,z=TRACK['layout']['positions'][int(index)]
                # Offset inside the tile but outside the digits/symbol, exact same path centers.
                point=(round((x+.48)*96),round((z+.40)*96))
                self.assertNotEqual(mild.getpixel(point),wild.getpixel(point),index)

    def test_raised_stadium_keeps_all_racing_cells_clear(self):
        for kind in ('mild','wild'):
            body=json.loads((CARD/f'models/item/magical_athlete/board/{kind}.json').read_text(encoding='utf-8'))
            base=next(e for e in body['elements'] if e['name']=='board')
            self.assertEqual(base['from'],[0,8,0])
            self.assertEqual(base['to'],[16,8.06,16])
            props=[e for e in body['elements'] if e['to'][1]>8.14]
            self.assertGreater(len(props),50)
            self.assertTrue(any(e['name'].startswith('light_mast') for e in props))
            for element in props:
                for x,z in TRACK['layout']['positions']:
                    overlap=min(element['to'][0],x+.67)>max(element['from'][0],x-.67) and min(element['to'][2],z+.67)>max(element['from'][2],z-.67)
                    self.assertFalse(overlap,(kind,element['name'],x,z,'decoration blocks a racing cell'))

    def test_six_distinct_face_only_guess_models(self):
        signatures=set()
        for value in range(1,7):
            path=CARD/f'textures/item/magical_athlete/guess/{value}.png'
            with Image.open(path) as image:
                self.assertEqual(image.mode,'RGBA')
                self.assertEqual(image.size,(96,96))
                self.assertEqual(image.getpixel((0,0))[3],0)
            signatures.add(hashlib.sha256(path.read_bytes()).hexdigest())
            model=json.loads((CARD/f'models/item/magical_athlete/guess/{value}.json').read_text(encoding='utf-8'))
            self.assertEqual(model['parent'],'minecraft:item/generated')
            self.assertEqual(model['textures']['layer0'],f'card:item/magical_athlete/guess/{value}')
        self.assertEqual(len(signatures),6)

    def test_sound_license_hashes_codec_and_loop(self):
        manifest=json.loads((SOURCE/'audio/manifest.json').read_text(encoding='utf-8'))
        self.assertEqual(manifest['license'],'Mixed; see each audio entry')
        self.assertEqual(manifest['loop_ticks'],640)
        definitions=json.loads((RP/'assets/magical_athlete/sounds.json').read_text(encoding='utf-8'))
        self.assertEqual(len(definitions),13)
        for event,data in manifest['audio'].items():
            ns,location=data['resource'].split(':',1)
            path=RP/f'assets/{ns}/sounds/{location}.ogg'
            self.assertTrue(path.exists(),event)
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),data['sha256'])
            probe=json.loads(subprocess.check_output(['ffprobe','-v','error','-show_entries','format=duration:stream=codec_name,channels','-of','json',str(path)],text=True))
            self.assertEqual(probe['streams'][0]['codec_name'],'vorbis')
            self.assertEqual(probe['streams'][0]['channels'],1)
            if event=='bgm':
                self.assertAlmostEqual(float(probe['format']['duration']),32,places=2)
                self.assertTrue(definitions[event]['sounds'][0]['stream'])
            elif event=='bgm_wild':
                self.assertAlmostEqual(float(probe['format']['duration']),data['duration'],places=2)
                self.assertTrue(definitions[event]['sounds'][0]['stream'])
                self.assertEqual(data['loop_ticks'],math.ceil(data['duration']*20))
                self.assertEqual(hashlib.sha256((SOURCE/'audio'/data['original']).read_bytes()).hexdigest(),data['original_sha256'])
                self.assertLess(abs(data['normalization']['output_lufs']-data['normalization']['reference_lufs']),1)
                self.assertLess(data['normalization']['output_true_peak_dbfs'],-1)
            else:
                self.assertEqual(data['license'],'CC0-1.0')
        self.assertTrue((SOURCE/'audio/LICENSE.txt').exists())
        self.assertTrue((RP/'.source/catan/audio/kenney/casino/License.txt').exists())


if __name__=='__main__':
    unittest.main(verbosity=2)
