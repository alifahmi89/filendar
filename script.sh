#!/bin/bash
# Create data availability into monthly calendar
# Author   : Ali Fahmi
# Created  : 2020-12-30
# Modified : 2021-03-01

[ $# -lt 4 ] && echo "Usage: $0 path station yyyy mm" && exit 1


dir=$1
sta=$2
thn=$3
bln=$4

table=monthly/${sta}_$thn-$bln.html
namabln=$(date -d "$thn-$bln-01" +%B)
#days=( Sun Mon Tue Wed Thu Fri Sat )
days=( Su Mo Tu We Th Fr Sa )

mkdir -p monthly

echo "
<table>
<tr>
	<th colspan=\"7\" align=\"center\" style=\"color:white;background-color:black\">$namabln $thn</th>
</tr>" > $table

#day name
echo "<tr>" >> $table
for a in ${days[@]};
do 
	echo -e "\t<td align=\"center\" style=\"color:white ;background-color:gray\">$a</td>" >> $table
done
echo "</tr>" >> $table

for week in {1..6};
do
	echo "<tr>" >> $table

	for day in {1..7}; 
	do 
		col=$(( 2 * $day + $day - 1 )); 
		tgl=$(cal $bln $thn | sed -n $(( week + 2 ))p | tr -cd "[:print:]" | sed 's/_//g' | head -c$col | tail -c2 | tr -d ' ')

		angka='^[0-9]+$'
		if [[ $tgl =~ $angka ]];
		then 
			tgldir=$(printf "%02d" $tgl)
			val=$tgldir

			#percent=$(shuf -i 0-100 -n 1)
			if [ ! -d "$dir/$sta" ];
			then
				echo "The directory $dir/$sta doesn't exist."
				exit 1
			fi

			count=$(ls $dir/$sta/$thn/$thn-$bln-$tgldir/*z* | wc -l)
			#percent=$(printf %.1f "$(( 10**3 $count / 24 * 100 ))e-3")
			
			#color
			if (( $count == 0 ))
			then
				color=red
			elif ((	1<=$count && $count<=8 ))
			then
				color=orange
			elif (( 9<=$count && $count<=16 ))
			then
				color=yellow
			elif (( 17<=$count && $count<=24 ))
			then
				color=lime
			else
				color=cyan
			fi

			echo "$sta;$thn-$bln-$tgldir;$count" #| tee -a $txt 2>&1
		else
			echo "[ ]"
			val="&nbsp;"
			color=lightgrey
		fi

		echo -e "\t<td align=\"center\" style=\"background-color:$color\">$val</td>" >> $table
	done

	echo "</tr>" >> $table
done

echo "</table>" >> $table
