#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 2 – semestr letni 2020/2021
#
# Celem zajęć jest nabranie doświadczenia w podstawowej pracy z powłoką Bash,
# w szczególności w nawigowaniu po drzewie katalogów i sprawdzaniu uprawnień.
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
# Utworzyć kopię zapasową wszystkich ważnych plików z katalogów `aaa` i `bbb`
# wewnątrz katalogu `zapasy` w `ddd`. Ważne pliki to takie, które zostały
# zabezpieczone przed modyfikacją (czyli nie mamy prawa zapisu do nich).
# Zachować strukturę plików – czyli w katalogu `zapasy` mają powstać katalogi
# `aaa`, `bbb` i wszelkie potrzebne ich podkatalogi.
#

pwdVar=`pwd`

backupDirectory="${pwdVar}"/ddd/zapasy
mkdir "${backupDirectory}"
var1="${backupDirectory}"

wyszukajIzbackupuj(){
var2="${var1}"
var1="${var1}"/$1
mkdir "${var1}"
cd $1
for nazwa in *
do
        if [ -d "$nazwa" ]; then
                wyszukajIzbackupuj "$nazwa"
        elif [ ! -w "${nazwa}" ]; then
                cp -i "${nazwa}" "${var1}"
        fi

done
var1="${var2}"
cd ..
return
}

wyszukajIzbackupuj aaa
wyszukajIzbackupuj bbb

echo Koniec skryptu 8
