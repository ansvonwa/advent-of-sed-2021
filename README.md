# Advent of `sed`, 2021
Some solutions for [adventofcode.com/2021](https://adventofcode.com/2021) in pure `sed`.

So far, the sed scripts use _only_ regex replace (`s/a/b/`) and conditional jumps (`:x;/a/bx`).

## Run
```bash
$ sed -f 1a.sed 1a.txt
```
