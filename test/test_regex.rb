

rgx = /(.)(.)(.)/
'abcd' =~  rgx
[$1,$2,$3,$-1]

 /a#{rgx}+b/