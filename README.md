# fdswap
shell script to redirect the output of a process to desired file

## Problem Statement
It often happens that, we run a process in the terminal, and the process starts printing out in the terminal, not letting us do our other tasks.

In that case, we might want to run the process in the background. So we do `Ctrl + z` and then the process is stopped and we do `bg` to make it run on background.

But.. to gour greatest disappointment, the program, though running in the background, uses the terminal to do its output, once again, not letting us do our other tasks.

Here is where the use of `fdswap` comes to play.

## Installation
Clone this repo https://github.com/Bibekpandey/fdswap.git

Go to the repo directory and run setup.sh [ `./setup.sh` ]

## Usage
`fdswap <process name> [ <path to file where redirection needs be done> ]`

If no path specified, default file location is /tmp/stdout

BEWARE!! The process you want to redirect output, should be stopped first, [ `Ctrl + z ` ]

After running the command, you may wish to view the output redirection. You can do that by `tail -f <file location>`

## Example
```
user$ ping google.com
... output comes here
<Ctrl+z>
Stopped[+1]
user$ fdswap 'ping google.com' output.log
user$ tail -f output.log
... output continues here
```
