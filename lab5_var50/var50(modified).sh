# !/bin/bash

#проверка количества аргументов
if [ $# -ne 3 ]; then echo "Неверное число аргументов (должны быть переданы три файла)"; exit; fi 

#проверка существования читабельных файлов
if [ ! -f "$1" -o ! -f "$2" -o ! -f "$3" -o ! -r "$1" -o ! -r "$2" -o ! -r "$3" ]; then echo "По крайней мере один параметр не является читаемым файлом"; exit; fi

#проверка на непустые файлы
if [ ! -s "$1" -o ! -s "$2" -o ! -s "$3" ]; then echo "1-ый и(или) 2-ой и(или) 3-ий файл пустой"; exit; fi

#функция для проверки формата файла (ищет строки не подходящие под формат)
check_format(){
value=0
if egrep -vq "^[[:space:]]*[-]?[0-9]+([[:space:]]+[-]?[0-9]+)?([[:space:]]+[-]?[0-9]+)?([[:space:]]+[-]?[0-9]+)?[[:space:]]*$" $1; 
then
value=1
fi
return $value
}

if ! check_format $1; then echo "1-ый файл не соответствует формату"; exit; fi
if ! check_format $2; then echo "2-ой файл не соответствует формату"; exit; fi
if ! check_format $3; then echo "3-ий файл не соответствует формату"; exit; fi

#создаём файл, в который будем записывать произведения
>sort_pr_$$
#проходим по всем файлам
for i in "$@"
do
   while read line; do
      #в каждой строке находим произведение и записываем в sort_pr
      pr=1
      for val in $line; do
         pr=$((pr*val))
      done
      echo $pr>>sort_pr_$$ 
   done < $i
done
cat sort_pr_$$| sort -n 
rm sort_pr_$$
