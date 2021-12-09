:a;N;$!ba;

s/$/\n/
s/\(.\)[a-z]\+ \(.\)\n/\1\2\n/g

s/\(.\)1/\1/g
s/\(.\)2/\1\1/g
s/\(.\)3/\1\1\1/g
s/\(.\)4/\1\1\1\1/g
s/\(.\)5/\1\1\1\1\1/g
s/\(.\)6/\1\1\1\1\1\1/g
s/\(.\)7/\1\1\1\1\1\1\1/g
s/\(.\)8/\1\1\1\1\1\1\1\1/g
s/\(.\)9/\1\1\1\1\1\1\1\1\1/g

s/\n//g

# accumulate d+,u+ -> AD
s/^/X/
s/Xfffff/fffffX/

# remove du's and ud's
:du1
s/uuuuuddddd//g
s/ud//g
/ud/ bdu1

:du2
s/ddddduuuuu//g
s/du//g
/du/ bdu2


:acc
s/\(D*\)Xd\{64\}/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\1DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDX/
s/\(D*\)Xd\{16\}/AAAAAAAAAAAAAAAA\1DDDDDDDDDDDDDDDDX/
s/\(D*\)Xd\{4\}/AAAA\1DDDDX/
s/\(D*\)Xd/A\1DX/
/Xd/ bacc
s/fA/f|A/
:carry1
s/|A\{10\}/A|/
/|A\{10\}/ bcarry1


#:lower
s/D/d/g
#/D/ blower

s/\([A|]*\)\(d*\)Xf/f\1X\2/
/Xd*f/ bacc

/du/ bdu2

s/Xd*//

s/f\([A|]\)/f*\1/
s/*|\+/*/
s/A/a/g

# use number generation from task 1
s/[fd]/i/g

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

# multiply
s/$/+/
:mult
:rmOnes
#s/[a-z]\*\([^\+]\)\+/X/
s/[a-z]\*\([^\+]\++\)/*\1\1/
/[^\|]\*/ brmOnes

# div left factor by 10, mult right by 10
s/|\*\([^\+]\+\)+/*\1|+/
/.\*/ bmult

# 0*x is left, rm
s/\*\([^\+]\+\)+//


# set marker
s/\+/X+/g
:add
# add digit X
s/\(|\|\+\)\([a-z]*\)X\([^X]\+\)\(|\|\+\)\([a-z]*\)X/\1\2\5X\3\4Y/g
# repeat as long as there are multiple X's (=unfinished digit marker)
/X.*X/ badd
# carry
:carry
s/\(|\?\)[a-z]\{10\}\([a-z]*\)X/c|\2X/
/[a-z]\{10,\}X/ bcarry
# next digit
s/|\([a-z]*\)[XY]/X|\1/g

/X.*X/ badd
/[a-z]\{10,\}X/ bcarry

# remove X and +Y|||
s/X//;s/+Y|*//g
s/^/|/;s/+$//

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
