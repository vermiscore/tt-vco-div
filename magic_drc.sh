#!/bin/bash
# usage: ./magic_drc.sh <file.gds>   -> prints counts, writes <file>_drc.lyrdb
GDS=$1; TOP=tt_um_vermiscore_vco_div
PDK=${SKY130A:-$HOME/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A}
OUT=${GDS%.gds}_drc.lyrdb
magic -dnull -noconsole -rcfile "$PDK/libs.tech/magic/sky130A.magicrc" << EOF 2>&1 | grep -E "^(RULE|COUNT)"
gds read $GDS
load $TOP
select top cell
drc euclidean on
drc style drc(full)
drc check
drc catchup
set s [cif scale out]
set f [open $OUT w]
puts \$f "<?xml version=\"1.0\" encoding=\"utf-8\"?><report-database><top-cell>$TOP</top-cell><categories>"
set r [drc listall why]
foreach {why boxes} \$r { regexp {\(([^)]+)\)} \$why - c; set c [string map {. _ / _} \$c]; puts \$f "<category><name>\$c</name></category>" }
puts \$f "</categories><cells><cell><name>$TOP</name></cell></cells><items>"
foreach {why boxes} \$r {
  regexp {\(([^)]+)\)} \$why - c; set c [string map {. _ / _} \$c]
  puts "RULE \$why : [llength \$boxes]"
  foreach b \$boxes {
    lassign \$b x1 y1 x2 y2
    puts \$f "<item><category>\$c</category><cell>$TOP</cell><values><value>box: ([expr {\$x1*\$s}],[expr {\$y1*\$s}];[expr {\$x2*\$s}],[expr {\$y2*\$s}])</value></values></item>"
  }
}
puts \$f "</items></report-database>"
close \$f
puts "COUNT: [drc listall count total]"
quit -noprompt
EOF
echo "markers: $OUT"
