$tellraw @a[tag=wq.actor,limit=1] {text:"[ $(label) ]",color:"green",bold:true,click_event:{action:"run_command",command:"/trigger wq_action set $(value)"}}
