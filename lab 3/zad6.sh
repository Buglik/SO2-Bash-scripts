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
# Zadanie 6.
# Odnaleźć wszystkie dowiązania miękkie, zdefiniowane w katalogu `ccc`, które
# poprawnie wskazują na jakieś miejsce w systemie plików (ich cel istnieje).
# Wyświetlić ścieżki do wskazywanych miejsc, konstruując je jako ścieżki
# względem katalogu domowego bieżącego użytkownika (zmienna ${HOME}).
#

varPWD=`pwd`

findNotEmptyLinks(){
        cd "${varPWD}"/$1
        for nazwa in *
        do
                if [ -h "${nazwa}" ]; then
                        var=`readlink "${nazwa}"`
                        if [ -e "${var}" ];then
				varSrc=`realpath "${var}"`
                                varHomeSrc=${varSrc##*${HOME}}
			       	#echo "${varSrc}"
				echo "${varHomeSrc}"
                        fi
                fi
        done
}

findNotEmptyLinks ccc

echo Koniec skryptu 6
