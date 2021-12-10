:a;N;$!ba;

s/\(.\)/|\1/g

s/|\n/X\n/g

:combine
s/|\([01]*\)X\([^X]\+\)|\([01]*\)X/|\1\3X\2|Y/g
:01
s/01//g;s/10//g
/01/ b01; /10/b01
/X.*X/ bcombine

s/|\([01]*\)X/X|\1/
s/|Y/X/g

/\([01]\)X.*X/ bcombine

s/\nX//g
s/|\([01]\)[01]*/|\1/g
s/X|//

# negate
# gamma -> epsilon
s/.*/\0+ * \0+/

:01AB
s/\(*.*\)0/\1A/
s/\(*.*\)1/\1B/
/*.*[01]/ b01AB

s/A/1/g;s/B/0/g

# i is the current base (2**n) followed by the sum
s/\n/i\n/g
:bin2dec
s/1\([i|]*i\)/\1+\1/g
s/0i/i/g
# double i
s/\([01]|\)\(i\+\)\(|*\)\(i*\)\(|*\)\(i*\)\(|*\)\(i*\)/\1\2\2\3\4\4\5\6\6\7\8\8/g
# carry
s/|i\{10\}/i|/g
# rm | between [01] and i
s/\([01]\)|\+i/\1i/g
/[01]i/ bbin2dec
#remove current base
s/\(^\| \)[i|]\++/\1/g

s/\n//g
s/\(^\| \* \)/\1|/g

# first: add, then multiply (which needs another add at the end)
badd

:mult
s/+ \* /*/
:rmOnes
#s/[a-z]\*\([^\+]\)\+/X/
s/[a-z]\*\([^\+]\++\)/*\1\1/
/[^\|]\*/ brmOnes

# div left factor by 10, mult right by 10
s/|\*\([^\+]\+\)+/*\1|+/
/.\*/ bmult

# 0*x is left, rm
s/\*\([^\+]\+\)+//

s/c/i/g


s/+|/+/g


:add
# set marker
s/\+/X+/g
:addloop
# add digit X
s/\(|\|\+\)\([a-z]*\)X\([^X*]*\)\(|\|\+\)\([a-z]*\)X/\1\2\5X\3\4Y/g
# repeat as long as there are multiple X's (=unfinished digit marker)
#/X.*X.*X/ baddloop
/X[^*]*X/ baddloop
# carry
:addcarry
s/\(|\?\)[a-z]\{10\}\([a-z]*\)X/c|\2X/g
/[a-z]\{10,\}X/ baddcarry
# next digit
s/|\([a-z]*\)[XY]/X|\1/g

#/X.*X.*X/ baddloop
/X[^*]*X/ baddloop
/[a-z]\{10,\}X/ baddcarry

# remove X and +Y|||
s/X//g;s/+Y|*//g


# multiply if we have a '*'
/\*/ bmult

# remove trailing +
s/+$//;s/^|*/|/

# replace jjjjj|iii by 53
:toNum
s/|[a-z]\{9\}/9/g
s/|[a-z]\{8\}/8/g
s/|[a-z]\{7\}/7/g
s/|[a-z]\{6\}/6/g
s/|[a-z]\{5\}/5/g
s/|[a-z]\{4\}/4/g
s/|[a-z]\{3\}/3/g
s/|[a-z]\{2\}/2/g
s/|[a-z]\{1\}/1/g
s/|$//g
s/|/0/g




:end
