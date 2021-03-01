#!/bin/bash
# Combine monthly data availability into yearly calendar
# Author   : Ali Fahmi
# Created  : 2020-12-30
# Modified : 2021-02-01

[ $# -lt 2 ] && echo "Usage: $0 station yyyy" && exit 1

sta=$1
year=$2
project="DOMERAPI/VELI Project"
table=yearly/${sta}_$year-all.html

mkdir -p yearly

#calendar title
echo "
<html>
<table>
<tr>
	<th style=\"font-size:20px\" colspan=\"3\">Availability data for station $sta on $year</th>
</tr>
<tr>
	<th style=\"font-size:14px\" colspan=\"3\">$project</th>
</tr>
<tr>
	<th style=\"font-size:10px\">&nbsp;</th>
</tr>
" > $table

#create calendar in 4 rows x 3 columns
for row in {1..4};
do
	echo "<tr>" >> $table
	for col in {1..3};
	do
		#month number: 1 = Jan, 12 = Dec
		monum=$(printf "%02d" $(( row * 2 + row + col - 3 )))
		#echo "row: $row, col: $col, monum: $monum"
		data=$(cat monthly/${sta}_$year-$monum.html)
		echo "<td align=\"center\">$data</td>" >> $table
	done
	echo "</tr>" >> $table
done

#calendar legend
echo "
<tr>
	<td align=\"left\">
		<table style=\"width:120px; height:120px\">
		<tr>
			<th style=\"color:white; background-color:black; font-size:14px\" colspan=\"2\" align=\"center\">Legend</th>
		</tr>
		<tr>
			<td style=\"background-color:red; width:18px\">&nbsp;</td>
			<td style=\"font-size:12px\">No data</td>
		</tr>
		<tr>
			<td style=\"background-color:orange\">&nbsp;</td>
			<td style=\"font-size:12px\">1 - 8 hours/day</td>
		</tr>
		<tr>
			<td style=\"background-color:yellow\">&nbsp;</td>
			<td style=\"font-size:12px\">9 - 16 hours/day</td>
		</tr>
		<tr>
			<td style=\"background-color:lime\">&nbsp;</td>
			<td style=\"font-size:12px\">17 - 24 hours/day</td>
		</tr>
		<tr>
			<td style=\"background-color:cyan\">&nbsp;</td>
			<td style=\"font-size:12px\">&gt;24 (data splitted)</td>
		</tr>
		</table>
	</td>
	<td colspan=\"2\" style=\"font-size:10px\" align=\"right\" valign=\"bottom\">
		This calendar was generated on $(date -u +%Y-%m-%d" "%H:%M) UTC using <a href=\"http://github.com/alifahmi89/filendar\">filendar</a>
	</td>
</tr>" >> $table

echo -e "</table>\n</html>" >> $table
echo "Output: $(realpath $table)"

