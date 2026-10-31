# advancement 只恢复下次右键资格；输入在 tick 中读该格记录的最后右键者。
# 这样不会依赖 advancement 触发与 interaction NBT 写入的先后顺序。
advancement revoke @s only xiangqi:click_cell
