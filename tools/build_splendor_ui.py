"""停用旧市场对话框和旧 trigger；局内操作全部由桌面与预定牌完成。"""
from build_splendor_game import put

LEGACY = ['autopay', 'bank_append', 'bank_summary', 'begin', 'blind', 'button', 'button_append', 'card_icon', 'card_picture', 'details', 'dispatch', 'edit', 'editor_row', 'editor_show', 'handle', 'market', 'market_icon', 'market_slot', 'music', 'noble_icon', 'noble_slot', 'nobles', 'open', 'payment_summary', 'payment_text', 'private', 'private_show', 'public', 'public_append', 'public_player', 'read_card', 'read_target', 'reserve_slot', 'reserved', 'return_begin', 'row_append', 'rules', 'show', 'stale', 'submit_buy', 'submit_noble', 'submit_reserve', 'submit_return', 'submit_take', 'summary', 'table_summary', 'toggle_music', 'token_begin']


def main():
    for name in LEGACY:
        put('ui/'+name, 'return 0')
    from build_splendor_direct import build
    build()


if __name__ == '__main__':
    main()
