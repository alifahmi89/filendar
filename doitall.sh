[ $# -lt 3 ] && echo "Usage: $0 filepath start_year end_year" && exit 1

dir=$1
startyear=$2
endyear=$3
scriptpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

for sta in $(ls $dir);
do 
	for yr in $(seq $startyear $endyear); 
	do 
		for mo in {01..12}; 
		do 
			$scriptpath/script.sh $dir $sta $yr $mo
		done

		$scriptpath/combine.sh $sta $yr
	done
done
