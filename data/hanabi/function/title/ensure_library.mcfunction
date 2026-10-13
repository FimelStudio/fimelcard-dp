# 主数据包与BetterTitle是两个独立数据包，不能依赖load标签的执行先后顺序。
# 若BetterTitle尚未完成初始化，则在花火加载时主动初始化一次。
execute unless data storage fimel_title:io panels run function fimel_title:code/load
