#!/bin/bash

PID='-1' #pid of the required process
file='-1'$2

if [ $file == '-1' ]; then
    file=/tmp/stdout
else
    file=$2
fi

while read -a line; do
    pid=${line[0]}
    stat=${line[1]}
    cmd=${line[2]}
    grp="grep"
    if [ $stat == 'T' ]; then
        # && [ "$cmd" != "$grp" ] && [ $$ -ne $pid ]; then
        #echo found
        PID=$pid
    fi
done < <(ps ax -o pid,state,command | grep $1)

if [ $PID == '-1' ]; then
    echo ''
    echo No such process is found
    echo USAGE: fdswap '<processname> [<redirect file path>]'
    echo if no path specified default is /tmp/stdout
    echo NOTE: be sure to first stop the process '[ Ctrl + Z ]'
    echo ''
    return
fi

#echo pid is : $PID

mx=0 # to find out the file descriptor of the new file created

for fd in `sudo ls /proc/$PID/fd`; do
    if [ $fd -gt $mx ]; then
        mx=$fd
    fi
done

mx=`expr $mx + 1` # because new file descriptor is 1 more than the existing max fd

(
    echo 'call creat("'$file'", 0600)'
    echo 'call dup2('$mx', 1)'
) | sudo gdb -p $PID  > tmp

rm tmp

echo output stored in /tmp/stdout
echo running the process $1 in background
bg
echo to see output use '"tail -f '$file'"'
