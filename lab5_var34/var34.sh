# !/bin/bash

#проверка количества аргументов
if [ $# -ne 1 ]; then echo "Неверное число аргументов (должен быть передан один файл)"; exit; fi 

#проверка существования читабельного файла
if [ ! -f "$1" -o ! -r "$1" ]; then echo "Параметр не является читаемым файлом"; exit; fi

#проверка на непустой файл
if [ ! -s "$1" ]; then echo "Файл пустой"; exit; fi

str_num=$(cat "$1"|wc -l)
#проверка на количество строк
if [ $str_num -lt 2 ]; then echo "В файле меньше двух строк"; exit; fi

# -n - не выводить перевод строки
echo -n "Введите целое число:  "
# Ввод строчки в переменную s
read s
#проверка формата введённой строки
check=$(echo "$s" | grep -E ^\-?[0-9]+$)
if [ "$check" = '' ]; then echo "Формат строки неверный (должно быть целое число)"; exit; fi  

cur_num=0
counter=0
while true
do
#переходим к следующей строку
    cur_num=$((cur_num + 1))
#выводим строку под номером cur_num
    echo "$(cat $1| head -n$cur_num| tail -n1)"
    counter=$((counter + 1))
#Если было выведено две строки, то выводим введенную
    if [ $counter -eq 2 ]; then sleep 6; echo $s; sleep 6; counter=0; fi
#Если конец файла то возвращаемся к первой строке
    if [ $cur_num -eq $str_num ]; then cur_num=0; fi
done

#Ctrl-C завершить
