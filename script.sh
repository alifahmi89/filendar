#!/bin/bash
# Data availability calendar
# Author  : Ali Fahmi
# Created : 2020-12-30

[ $# -lt 4 ] && echo "Usage: $0 yyyy mm path station" && exit 1

#function getpercent()
#{
#	sta=	
#}

thn=$1
bln=$2
dir=$3
sta=$4

table=html/$thn-$bln.html
#txt=output.txt
namabln=$(date -d "$thn-$bln-01" +%B)
#days=( Sun Mon Tue Wed Thu Fri Sat )
days=( Su Mo Tu We Th Fr Sa )

echo "
<style> 
table, td, th 
{
	border: 1px solid black;
}

table 
{
	border-collapse: collapse; 
	width: 25%;
}
	
th 
{
	height: 30px;
}
	
</style>" > $table

#> $txt
#echo "<table border=1>" > $table
echo "
<table>
<tr>
	<th colspan="7" align="center" style="color:white\;background-color:black">$namabln $thn</th>
</tr>" >> $table

#day name
echo "<tr>" >> $table
for a in ${days[@]};
do 
	echo "<td align="center" style="color:white\;background-color:gray">$a</td>" >> $table
done
echo "</tr>" >> $table

for week in {1..6};
do
	data=""

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
				echo "Directory $dir/$sta doesn't exist."
				exit 1
			fi

			count=$(ls $home/$sta/$thn/$thn-$bln-$tgldir/*z* | wc -l)
			percent=$(( $count / 24 * 100 ))
			
			#color
			if (( 0<=$percent && $percent<=24 ))
			then
				color=red
			elif ((	25<=$percent && $percent<=49 ))
			then
				color=orange
			elif (( 50<=$percent && $percent<=74 ))
			then
				color=yellow
			else
				color=lime
			fi

			echo "$thn-$bln-$tgldir;$percent" #| tee -a $txt 2>&1
		else
			echo "[ ]"
			val="&nbsp;"
			color=lightgrey
		fi
		data="$data<td align="center" style="background-color:$color">$val</td>"
	done
	row="<tr>$data</tr>"
	echo "$row" >> $table
done

echo "</table>" >> $table

#awk -F';' 'BEGIN { print "<table border="1">" } { print "<tr><td>" $1 "</td><td>" $2 "</td></tr>" } END  \ 
#	{ print "</table>" }' $txt > $html
