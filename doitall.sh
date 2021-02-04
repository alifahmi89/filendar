[ $# -lt 1 ] && echo "Usage: $0 filepath" && exit 1

dir=$1

for sta in MEA{01..05};
do 
	for yr in {2013..2020}; 
	do 
		for mo in {01..12}; 
		do 
			./script.sh $dir $sta $yr $mo
		done

		./combine $sta $yr
	done
done
