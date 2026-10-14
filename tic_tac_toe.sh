#!/bin/bash

# computer O turno 0
# utente   1 turno 1

function draw_grid(){
	table=$1
     row0=""
	 row1="     │     │     " 
	 row2="  ${table:0:1}  │  ${table:1:1}  │  ${table:2:1}  "
	 row3="     │     │     " 
	 row4="─────┼─────┼──────" 
	 row5="     │     │     " 
	 row6="  ${table:3:1}  │  ${table:4:1}  │  ${table:5:1}  "
	 row7="     │     │     " 
	 row8="─────┼─────┼──────" 
	 row9="     │     │     " 
	row10="  ${table:6:1}  │  ${table:7:1}  │  ${table:8:1}  "
	row11="     │     │     " 
	row12=""
	
	for i in {0..12}
	do
		var_name="row$i"
		echo "${!var_name}"
	done

}

function check_win(){
	table=$1
	
	sol1="123"
	sol2="456"
	sol3="789"
	sol4="147"
	sol5="258"
	sol6="369"
	sol7="159"
	sol8="357"
	
	result="-"
	
	for i in {1..8}
	do
		var_name="sol$i"
		places="${!var_name}"
		
		i1=$(( ${places:0:1} - 1 ))
		i2=$(( ${places:1:1} - 1 ))
		i3=$(( ${places:2:1} - 1 ))

		v1="${table:$i1:1}"
		v2="${table:$i2:1}"
		v3="${table:$i3:1}"
		
		if [ $v1 = $v2 ] && [ $v2 = $v3 ]
		then
			result=$v1
			break
		fi
	done
    echo "$result"
}

table="123456789"
remain="123456789"
pattern_table="^[OX]{9}$"


turn=$((RANDOM%2))
while  [[ ! "$table" =~ $pattern_table ]]
do
	
	
	if [ $turn -eq 0 ]
	then
		ind=$(( RANDOM % ${#remain} ))
		place="${remain:$ind:1}"
		table="${table:0:place-1}O${table:place}"
	else
		draw_grid $table
		while true
		do
		    pattern_posto="^[$remain]$"
			read -p 'In che posto inserire la X: ' place
			if [[ ! "$place" =~ $pattern_posto ]]
			then
				echo "Errore: Inserire un posto valido."
			else9
				break
			fi
		done
		table="${table:0:place-1}X${table:place}"
	fi
	remain="${remain/$place/}"
	turn=$(( (turn+1)%2)) 
	
	vincitore=$(check_win "$table")

	if [ "$vincitore" = "X" ]; then
		draw_grid $table
		echo "Ha vinto l'utente"
		break
	elif [ "$vincitore" = "O" ]; then
		draw_grid $table
		echo "Ha vinto il computer"
		break
	fi
done

if [ "$vincitore" = "-" ]; then
	draw_grid $table
	echo "Pareggio!"
fi