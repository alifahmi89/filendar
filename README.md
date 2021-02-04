# filendar
Create hourly seismic (.gcf) file availability in a monthly/yearly calendar format.
- `script.sh` : create monthly data calendar.
- `combine.sh` : combine the script.sh result.
- `doitall.sh` : do both script above in one step. It only asks for the main path. For different file path, edit the count variable in script.sh file.


**File path format:**

`/path/to/file/STA/yyyy/yyyy-mm-dd/yyyymmdd_HHMM_sssscc.fff`

`STA   = station name, e.g. MELEK`

`yyyy  = year`

`mm    = month`

`dd    = day`

`HH    = hour`

`MM    = minutes`

`ssss  = serial number, e.g. 4y88`

`cc    = channel, e.g. {e|n|z}2`

`fff   = file format, e.g. gcf`


