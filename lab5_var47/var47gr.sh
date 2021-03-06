# !/bin/bash

#проверка количества аргументов
if [ $# -ne 2 ]; then echo "Неверное число аргументов (должны быть переданы два файла)"; exit; fi 

#проверка существования читабельных файлов
if [ ! -f "$1" -o ! -f "$2" -o ! -r "$1" -o ! -r "$2" ]; then echo "1-ый и(или) 2-ой параметр не является читаемым файлом"; exit; fi

#проверка на непустые файлы
if [ ! -s "$1" -o ! -s "$2" ]; then echo "1-ый и(или) 2-ой файл пустой"; exit; fi

#функция для проверки формата файла (ищет строки не подходящие под формат)
check_format(){
if egrep -vq "^[[:space:]]*[-]?[0-9]+[[:space:]]*$" $1; 
then
echo 0
else
echo 1
fi
}

#проверка формата файлов
if [ $(check_format $1) -eq 0 -o $(check_format $2) -eq 0 ]; then echo "1-ый и(или) 2-ой файл не соответствуют формату"; exit; fi

#копируем содержимое файлов в out, удаляя ненужные пробелы
tr -d ' ' <$1 >out
tr -d ' ' <$2 >>out

echo "Первый файл: "
cat $1
echo "Второй файл: "
cat $2
echo "Отсортированные,имеющиеся в обоих файлах, уникальные числа: "
cat out| sort -n| uniq -d
