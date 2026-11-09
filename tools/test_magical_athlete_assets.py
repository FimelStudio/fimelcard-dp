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
            path=CARD/f"textures/item/magical_athlete/racer/{entry['slug']}.png"
            with Image.open(path) as image:
                self.assertEqual(image.size,(128,128))
                self.assertEqual(image.mode,'RGBA')
                self.assertIsNotNone(image.getchannel('A').getbbox())
            signatures.add(hashlib.sha256(path.read_bytes()).hexdigest())
            for kind in ('racer','token'):
                self.assertTrue((CARD/f"items/magical_athlete/{kind}/{entry['slug']}.json").exists())
        self.assertEqual(len(signatures),36)

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
                self.assertEqual(item['model']['cases'][1]['model']['model'],'card:item/magical_athlete/'+relative.with_suffix('').as_posix())
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

    def test_hand_badges_use_poker_pose_and_keep_other_views_private(self):
        poker=json.loads((CARD/'models/item/fake_card.json').read_text(encoding='utf-8'))
        for entry in [*CHARS,{'slug':'back'}]:
            slug=entry['slug']
            body=json.loads((CARD/f'models/item/magical_athlete/hand/{slug}.json').read_text(encoding='utf-8'))
            for context in ('firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand','ground'):
                self.assertEqual(body['display'][context],poker['display'][context],(slug,context))
            for axis,center in enumerate((7,9,8.5)):
                low=min(e['from'][axis] for e in body['elements'])
                high=max(e['to'][axis] for e in body['elements'])
                self.assertAlmostEqual((low+high)/2,center,places=6)
            if slug=='back':continue
            item=json.loads((CARD/f'items/magical_athlete/hand/{slug}.json').read_text(encoding='utf-8'))['model']
            for context in ('gui','firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand','ground','head','fixed','none'):
                selected=item['fallback']
                for case in item['cases']:
                    if context in case['when']:
                        selected=case['model'];break
                if context=='gui':
                    expected='card:item/magical_athlete/token/'+slug
                elif context.startswith('firstperson_'):
                    expected='card:item/magical_athlete/hand/'+slug
                else:
                    expected='card:item/magical_athlete/hand/back'
                self.assertEqual(selected['model'],expected,(slug,context))

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

    def test_sound_license_hashes_codec_and_loop(self):
        manifest=json.loads((SOURCE/'audio/manifest.json').read_text(encoding='utf-8'))
        self.assertEqual(manifest['license'],'CC0-1.0')
        self.assertEqual(manifest['loop_ticks'],640)
        definitions=json.loads((RP/'assets/magical_athlete/sounds.json').read_text(encoding='utf-8'))
        self.assertEqual(len(definitions),12)
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
        self.assertTrue((SOURCE/'audio/LICENSE.txt').exists())
        self.assertTrue((RP/'.source/catan/audio/kenney/casino/License.txt').exists())


if __name__=='__main__':
    unittest.main(verbosity=2)
