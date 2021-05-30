#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3 – semestr letni 2020/2021
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
#
# Przygotowane rozwiązania nie muszą być całkowicie uniwersalne. Zakładamy,
# że ogólna struktura katalogów się nie zmienia (nie będzie już więcej/mniej
# poziomów podkatalogów), jednakże same nazwy i zawartości plików (o ile
# nie są podane wprost w treści zadań) mogą być dowolne i ulegać zmianie,
# a przygotowane rozwiązania nadal powinny działać.
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 8.
# Odszukać w katalogu `ccc` wiszące dowiązania i podjąć próbę ich naprawy
# – zakładamy, że wskazywane przez nie nazwy plików są poprawne, ale doszło
# do jakiegoś zamieszania w strukturze katalogów. Należy odszukać pasujących
# plików w katalogach `aaa` i `bbb`, a jeśli odpowiednie pliki istnieją
# to wyświetlić nazwę dowiązania i po dwukropku proponowaną poprawną ścieżkę
# (na przykład: bravo:../aaa/bravo).
#

varPWD=`pwd`
varSrc=''
varF="tekstBoJeszczeNicNieznalazleeem"

findBezwzgledneLinksAndTryToRepair(){
        cd "${varPWD}"/$1
        for nazwa in `find . -xtype l`
        do
		#echo ${nazwa}
		#echo ===!====
		dowiazanie=`readlink -m ${nazwa}`
		#echo `basename ${dowiazanie}`
		#echo STARTING SEARCHING
		varDowiazanie=`basename ${dowiazanie}`
		lookForFile ${varDowiazanie}
		if [ ${varF} = "Znalazlem" ];then
			varF=nic
			echo ${nazwa}: ${varPath##*${HOME}}
			
		fi
		#echo ============
		cd "${varPWD}"/$1
	done

}

lookForFile(){
	cd ${varPWD}
	for plik in aaa bbb
	do
		#echo ${plik}
		if [ -e ${plik} ] && [ ${plik} = $1 ]; then
			#echo Znalazlem tu1
			#echo ${plik}
                        #echo `pwd`
			varF="Znalazlem"
			varPath=`pwd`/${plik}
			return
		elif [ -d ${plik} ]; then
			lookForFileInFolder ${plik} $1
		fi
	done
	return
}

lookForFileInFolder(){
	cd $1/
	#echo ==========
	#echo $2
	#echo =========
	for file in *
        do
		#echo ${file}
                if [ -e ${file} ] && [ ${file} = $2 ];then
                        #echo Znalazlem tu2
                        #echo ${file}
			#echo `pwd`
			varF="Znalazlem"
			#echo ${varF}
                        varPath=`pwd`/${file}
			return
                elif [ -d ${file} ];then
                        lookForFileInFolder ${file} $2
                fi
        done
	cd ..
	return
}
findBezwzgledneLinksAndTryToRepair ccc
echo Koniec skryptu 8


