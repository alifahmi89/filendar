for sta in MEA{01..05};
do 
	for yr in {2013..2020}; 
	do 
		for mo in {01..12}; 
		do 
			./script.sh /DOMERAPI/data3/ANTENNA/GCF $sta $yr $mo
		done

		./combine $sta $yr
	done
done
