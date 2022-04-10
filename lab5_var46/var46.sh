# !/bin/bash

#проверка количества аргументов
if [ $# -ne 1 ]; then echo "Неверное число аргументов (должен быть передан один файл)"; exit; fi 

#проверка существования читабельного файла
if [ ! -f "$1" -o ! -r "$1" ]; then echo "Параметр не является читаемым файлом"; exit; fi

#проверка на непустые файлы
if [ ! -s "$1" ]; then echo "Файл пустой"; exit; fi

#функция для проверки формата файла (ищет строки не подходящие под формат)
check_format(){
value=0
if egrep -vq "^[[:space:]]*[-]?[0-9]+[[:space:]]+[-]?[0-9]+[[:space:]]*$" $1; 
#v ищет неподходящие; q - тихий режим
then
value=1
fi
return $value
}

#проверка формата файлов
if ! check_format $1; then echo "Файл не соответствует формату"; exit; fi

>sort_sum_$$
while read line; do 
   sum=0
   for val in $line; do
      sum=$((sum+val))
   done
   echo $sum>>sort_sum_$$
done < $1
sort -rn sort_sum_$$| cat
rm sort_sum_$$
