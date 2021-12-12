:a;N;$!ba;

s/,//g
s/\n//g

# sort
:sort
s/\(.\+\)\(1\+\)/\2\1/g
s/\(3\+\)\(.*\)\(2\+\)/\3\2\1/g
s/\(4\+\)\(.*\)\(3\+\)/\3\2\1/g
s/\(5\+\)\(.\+\)/\2\1/g
/^\n*1*2*3*4*5*\n*$/bsorted
bsort

:sorted
# insert newlines
s/\(1*\)\(2*\)\(3*\)\(4*\)\(5*\)/\n\1\n\2\n\3\n\4\n\5\n\n\n\n\n/g
s/\([1-5]\)/i/g

#s/$/x/
#s/.*/i\nj\nk\nl\nm\nn\no\np\nq\n\n/

:grow
s/^\([^\n]*\)\n\(.*\)\n\([^\n]*\)\n\n\([^\n]*\)/\2+\1+\n\3\n\1\n\n\4+i+/

:add
# set marker
s/\+/X+/g
:addloop
# add digit X
#s/\(|\|\n\)\([a-z]*\)X\([^X*]*\)\(|\|\+\)\([a-z]*\)X/\1\2\5X\3\4Y/g
s/\([a-z]*\)X\([^X*]*\)\(|\|\+\)\([a-z]*\)X/\1\4X\2\3Y/g
# repeat as long as there are multiple X's (=unfinished digit marker)
/X[^\n]*X/ baddloop
# carry
:addcarry
s/\(|\?\)[a-z]\{10\}\([a-z]*\)X/c|\2X/g
/[a-z]\{10,\}X/ baddcarry
# next digit
s/\n\([a-z][^\n]*+\)/\n|\1/
s/|\([a-z]*\)[XY]/X|\1/g

/X[^\n]*X/ baddloop
#/[a-z]\{10,\}X/ baddcarry

# remove X and +Y||| and +
s/X//g;s/+Y|*//g;s/+//g;s/\n|/\n/g

# if counter is at 256, stop loop
#/ccc|iiiiii$/ bdebug
/cc|ccccc|iiiiii$/ badded
bgrow


:debug
b
#s/^\([^\n]*\)\n\(.*\)\([^\n]*\)\n\([^\n]*\)\n\n\([^\n]*\)/\2\3+\1+\n\4\n\1\n\n\5+i+/
s/^\([^\n]*\)\n\(.*\)\n\([^\n]*\)\n\n\([^\n]*\)/\2+\1+\n\3\n\1\n\n\4+i+/
s/\+/X+/g
s/\([a-z]*\)X\([^X*]*\)\(|\|\+\)\([a-z]*\)X/\1\4X\2\3Y/g
s/\(|\?\)[a-z]\{10\}\([a-z]*\)X/c|\2X/g
s/\n\([a-z][^\n]*+\)/\n|\1/
s/|\([a-z]*\)[XY]/X|\1/g
s/\([a-z]*\)X\([^X*]*\)\(|\|\+\)\([a-z]*\)X/\1\4X\2\3Y/g

b
s/X//g;s/+Y|*//g;s/+//g;s/\n|/\n/g
b


b


:added
# if there is no double-\n, exit
/\n\n/ btotalsum
boutput
:totalsum
s/\n/+/g;s/++/+\n/
#s/^/|/

badd

:output
# replace jjjjj|iii by 53
s/\(^\|\n\)|*/\1|/g
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



