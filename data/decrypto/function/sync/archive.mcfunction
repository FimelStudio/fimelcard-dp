$execute unless data entity @s data.decrypto.sync_history.$(side).k$(digit) run data modify entity @s data.decrypto.sync_history.$(side).k$(digit) set value []
$data modify entity @s data.decrypto.sync_history.$(side).k$(digit) append from storage decrypto:sync clue
