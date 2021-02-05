#!/bin/bash
# Combine data availability into yearly calendar
# Author   : Ali Fahmi
# Created  : 2020-12-30
# Modified : 2021-02-05

[ $# -lt 2 ] && echo "Usage: $0 station yyyy" && exit 1

sta=$1
year=$2
table=html/${sta}_$year-all.html

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
	<th style="font-size:18px" colspan="3" style="color:white\;background-color:black">Availability data for station $sta on $year</th>
</tr>" >> $table

#day name

for row in {1..4};
do
	echo "<tr>" >> $table
	for col in {1..3};
	do
		monum=$(printf "%02d" $(( row * 2 + row + col - 3 )))
		#echo "row: $row, col: $col, monum: $monum"
		data=$(cat html/${sta}_$year-$monum.html)
		echo "<td align="center">$data</td>" >> $table
	done
	echo "</tr>" >> $table
done

echo "<td align=center style=font-size:10px colspan=3>Generated using <a href="http://github.com/alifahmi89/filendar">filendar</a></td>" >> $table

echo "</table>" >> $table
echo "Output: $table"

