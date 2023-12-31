#!/bin/bash
arr=()
arr+="pid,cpu_utilization,process_name"

ps -eo pid:2,ppid:2,%mem:2,%cpu:2,cmd:2 --sort=-%cpu | head -n 11 | egrep -v PID |

sed -i 's/ /;/g' /tmp/raw_process_cpu.txt

while read -r line;
do
  IFS=";"
  read -ra my_array <<< "$line"

  pid="${my_array[0]}"
  cpu_util="${my_array[1]}"
  process="${my_array[2]}"

  IFS="/"
  read -ra my_array2 <<< "${my_array[2]}"
  process="${my_array2[-1]}"

  result="$pid,$cpu_util,$process"
  arr+=("$result")
done < /tmp/raw_process_cpu.txt

printf '%s\n' "${arr[@]}" > /tmp/deneme.csv
printf '%s\n' "${arr[@]}"
