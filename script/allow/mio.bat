cd /d %~dp0
cd aa
@echo off

::start download

wget -O i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -O i2.txt https://raw.githubusercontent.com/Potterli20/hosts/main/ad-allow.txt
wget -O i3.txt https://adaway.org/hosts.txt
wget -O i4.txt https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt
wget -O i5.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt
wget -O 16.txt https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/whitelist.txt
wget -O i7.txt https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/GermanFilter/sections/whitelist.txt 
wget -O i8.txt https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/TurkishFilter/sections/whitelist.txt 
wget -O i9.txt https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/SpywareFilter/sections/whitelist.txt


::add new rules
::wget -O i+number url

::end download

::no need to change
del /f /q *.html
del /f /q *hsts

::blankline
for %%i in (i*.txt) do type blank.dd>>%%i

::TheRuleMaker
::No need to change

::Merge
type frules.dd>mergd.txt
type i*.txt>>mergd.txt

::nore
gawk "!a[$0]++" mergd.txt>nore.txt

::del comments
(findstr /b /c:"@" nore.txt)>nord.txt

::count rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nord.txt')do set/a rnum=%%a
::error
set/a rnum+=1

::add title and date
echo ! Version: %date%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Total count: %rnum%>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt+brules.dd final.txt

::end
copy /y final.txt ..\..\..\allow.txt
del /f /q *.txt&exit