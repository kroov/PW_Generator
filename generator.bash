#!/bin/bash -x

die() {
	exit 171
}
while (( "$#" )) ; do
case $1 in
	--numbers )
		file="$file numbers" ;;
	--letters )
		file="$file letters" ;;
	--symbols )
		file="$file symbols" ;;
	--single )
		single=true ;;
	--length )
		shift && [[ $1 =~ ^-?[0-9]+$ ]] && snum="$1" ;;
	--max-length )
		shift && [[ $1 =~ ^-?[0-9]+$ ]] && enum="$1" ;;
	* )
		echo "Unknown parametr: $i" && die ;;
esac
shift
done

[[ $enum =~ ^-?[0-9]+$ ]] || enum=$snum

#echo "Using dictionaries:$file; iteration: $number"

declare -a alphabet
alphabet=( $(cat $file) )

generate(){
local pass=$2
#echo $iteration $pass is $number
if [ ! -z $iteration ] && [ $iteration -eq $num ] ; then 
	echo $pass 
else 
	for i in ${alphabet[*]} 
        do
     	local passwd="${pass}${i}"
	local iteration=$(($1+1))
        generate $iteration $passwd
        done
fi
}


for num in $(seq $snum $enum);do
password=""
#echo "generate $num $password"
generate 0 $password
done
