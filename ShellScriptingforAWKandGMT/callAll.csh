#!/bin/csh

# This script is just to combine all the shell scripts
csh problem1_final.csh
csh problem2_final.csh  
csh problem3_final.csh

# remove some unnecessary files
rm fctopo.grd 
rm fctopo.intns
rm gm.txt
rm hotcolor.cpt
rm data.grd
rm fctopo.cpt 
# open the pdfs
open *.pdf
