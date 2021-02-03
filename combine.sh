#!/bin/bash
# Data availability calendar
# Author  : Ali Fahmi
# Created : 2020-12-30

year=$1
table=html/$year-all.html

echo "
<style> 
table, td, th 
{
	border: 1px solid black;
}

table 
{
	#border-collapse: collapse; 
	width: 20%;
}
	
th 
{
	height: 200px;
}
	
</style>" > $table

echo "
<table>
<tr>
	<th style="font-size:28px" colspan="3" style="color:white\;background-color:black">$year Calendar</th>
</tr>" >> $table

#day name

for row in {1..4};
do
	echo "<tr>" >> $table
	for col in {1..3};
	do
		monum=$(printf "%02d" $(( row * 2 + row + col - 3 )))
		#echo "row: $row, col: $col, monum: $monum"
		data=$(cat html/$year-$monum.html)
		echo "<td align="center">$data</td>" >> $table
	done
	echo "</tr>" >> $table
done

echo "</table>" >> $table
echo "Output: $table"

#awk -F';' 'BEGIN { print "<table border="1">" } { print "<tr><td>" $1 "</td><td>" $2 "</td></tr>" } END  \ 
#	{ print "</table>" }' $txt > $html
