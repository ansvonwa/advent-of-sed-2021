# fill up to 4 digits
s/^/ 000/
:a;N;$!ba;
s/\n/\n000/g
s/0*\([0-9]\{4\}\)/\1/g
s/$/0\n0000\n0000\n0000/g

# make windows
s/\([0-9]\+\)\n\([0-9]\+\)\n\([0-9]\+\)\n\([0-9]\+\)/\1to\4 \2\n\3\n\4/g
s/\([0-9]\+\)\n\([0-9]\+\)\n\([0-9]\+\)\n\([0-9]\+\)/\1to\4 \2\n\3\n\4/g
s/\([0-9]\+\)\n\([0-9]\+\)\n\([0-9]\+to....\) \([0-9]\+\)/\1to\4 \2\n\3 \4/g
s/\([0-9]\+\)\n\([0-9]\+to....\) \([0-9]\+to....\) \([0-9]\+\)/\1to\4 \2 \3 \4/g

# replace equal starts
s/ \([0-9]\)\([0-9]\+\)to\1\([0-9]\+\)/ \2to\3/g
s/ \([0-9]\)\([0-9]\+\)to\1\([0-9]\+\)/ \2to\3/g
s/ \([0-9]\)\([0-9]\+\)to\1\([0-9]\+\)/ \2to\3/g

# replace endings, as we don't need them
s/ \([0-9]\)\([0-9]\+\)to\([0-9]\)\([0-9]\+\)/ \1to\3/g

# replace increasing by i, decreasing by d
s/\([0-9]\)to\1/equal/g
s/0to./i/g;s/.to0/d/g
s/1to./i/g;s/.to1/d/g
s/2to./i/g;s/.to2/d/g
s/3to./i/g;s/.to3/d/g
s/4to./i/g;s/.to4/d/g
s/5to./i/g;s/.to5/d/g
s/6to./i/g;s/.to6/d/g
s/7to./i/g;s/.to7/d/g
s/8to./i/g;s/.to8/d/g

#keep the i's
s/[^i]//g

#count the i's
s/i\{10\}/j/g
s/j\{10\}/k/g
s/k\{10\}/l/g
s/l\{10\}/m/g
s/m\{10\}/n/g

# insert _ between same char
s/\(.\)\1/\1_\1/g
s/\(.\)\1/\1_\1/g

# insert | between different chars
s/\([a-z]\)\([a-z]\)/\1|\2/g
s/\([a-z]\)\([a-z]\)/\1|\2/g

s/_//g
s/^/|/;s/$/|/

# replace jjjjj|iii by 53
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
