:a;N;$!ba;

s/\n\n/\n=====\n/g
s/$/=====\n/

:move
# replace all occurences of first number by 'X'
s/^\([0-9]\+\),\(.*[^ \n]\)\(\n\| \)\( \?\)\1\([\n ]\)/\1,\2\3 X\5/
/^\([0-9]\+\),\(.*\)\(\n\| \+\)\1\([\n ]\)/ bmove

# check if there is a full row(/col)
# row
s/=====\n\([^\n=]\+\n\)*\( \+X\)\{5\}/=====\nwinner:\n\0/g
/winner/ bwin
# col
s/=====\([\n ][0-9 ][0-9X]\)*\(. X[^=]\{12\}\)\{4\}. X/=====\nwinner:\n\0/g
/winner/ bwin

# drop first number
#:drop
s/^[0-9]\+[,\n]//
/[0-9]\+[,\n]/ bmove
s/^/something is wrong. no more numbers to draw. exiting./
bend

:rmboard
# remove winning boards
s/\nwinner:\n=====[^=]*=====//g
/ X  X  X  X  X/ bend
bmove

:win
# rm if there are multiple boards
/\(=====.*\)\{4\}/ brmboard

s/^\([0-9]\+\).*winner:\n=====\n\([^=]*\)=====.*/\1*\n\2/
# keep numbers only, insert +'s
s/. X//g;s/\n/ /g;s/ \+/\+/g

# insert |'s
s/\([0-9]\)\([0-9]\)/\1|\2/g
:num2i
s/0//g
s/[0-9]/i\0/g
y/123456789/012345678/
/[0-9]/ bnum2i
s/+\+/+/g

# prepare for add+mult+add
s/^/|/;s/*+/+ * |/

# add+mult+add from 3a
# first: add, then multiply (which needs another add at the end)
# format: |ii||iiii|iiiiiiii+i||ii|iiii+ii|iiiii|iiiiii+i|ii|iiiiiiii+iii|ii+i|iiiiii+iiiiiiii+iiii+ * |iiiii|i|ii+iiiiii|iiii+ii+i+
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
# fix beginning of carry if we got another digit
s/\(^\| \)c/\1|c/
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
s/|/0/g




:end
