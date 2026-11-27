"""完全提示奖励与普通提示逐牌已知信息一致；展示不改变提示状态或选牌命令。"""
import sys
import test_uno as base


class Fixtures(base.Fixtures):
    def case(self, name, commands):
        if name == 'real_reload': self.status_cases()
        super().case(name, commands)

    def status_cases(self):
        card = base.card(2)
        c = self.setup() + [
            'data modify storage hanabi:reward full_hint_cards set value {text:"",extra:[]}',
            'data modify storage hanabi:reward full_hint_status set value {text:"",extra:[]}',
            'scoreboard players set #reward_card_added hb_ctx 0',
            f'scoreboard players set {card} hb_color 2', f'scoreboard players set {card} hb_rank 3',
        ]
        for index, (color, number, text, tint) in enumerate([(0,0,'？','white'),(1,0,'色','aqua'),(0,1,'数','gold'),(1,1,'★','green')]):
            c += [f'scoreboard players set {card} hb_known_c {color}', f'scoreboard players set {card} hb_known_n {number}',
                  'data modify storage hanabi:dialog target_hand set value {text:"",extra:[]}',
                  'data modify storage hanabi:dialog target_status set value {text:"",extra:[]}',
                  'scoreboard players set #target_added hb_ctx 0',
                  f'execute as {card} run function hanabi:dialog/hint/append_target',
                  'data modify storage hanabi_status_test:probe expected set from storage hanabi:dialog target_status.extra[0]',
                  f'execute as {card} run function hanabi:reward/full_hint/append_card {{action:{1201+index}}}',
                  f'execute store success score #status_diff ut run data modify storage hanabi_status_test:probe expected set from storage hanabi:reward full_hint_status.extra[{index}]']
            c += self.score('#status_diff','ut',0,f'full_hint_matches_normal_status_{index}')
            c += self.check('data storage hanabi:reward full_hint_status.extra[{text:"'+text+'        ",color:"'+tint+'"}]',f'full_hint_status_{index}_has_expected_mark')
            c += self.score(card,'hb_known_c',color,f'full_hint_display_keeps_color_flag_{index}')
            c += self.score(card,'hb_known_n',number,f'full_hint_display_keeps_number_flag_{index}')
            c += self.check(f'data storage hanabi:reward full_hint_cards.extra[{{click_event:{{action:"run_command",command:"trigger hb_action set {1201+index}"}}}}]',f'full_hint_card_{index}_still_clickable')
        c += ['execute store result score #status_count ut run data get storage hanabi:reward full_hint_status.extra']
        c += self.score('#status_count','ut',4,'full_hint_one_status_per_card')
        c += ['data modify storage hanabi:reward full_hint_name set value {text:"目标"}',
              f'execute as {base.person(1)} run function hanabi:reward/full_hint/show_card with storage hanabi:reward']
        super().case('hanabi_full_hint_status',c)


if __name__ == '__main__':
    base.Fixtures = Fixtures
    sys.exit(base.main())
