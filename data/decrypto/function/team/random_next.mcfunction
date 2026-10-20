execute unless entity @a[tag=dc.team_pool] run return 0
execute as @a[tag=dc.team_pool,sort=random,limit=1] run function decrypto:team/assign_one
function decrypto:team/random_next
