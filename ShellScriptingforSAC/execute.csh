# This script is going to call the sac and using the sac macro
# plotdata.macro it will initiate sss and plot record section for each 
# component and save and open the plots as pdf and finally clean 
# the directory from all the junks
#!/bin/csh

sac <<EOF 
macro plotdata.macro

# quit SAC
quit
EOF

# open the pdf files
open *.pdf

# remove the junks and clear the directory
rm *.SAC
rm *.BHE
rm *.BHN
rm *.BHZ
rm *.txt
