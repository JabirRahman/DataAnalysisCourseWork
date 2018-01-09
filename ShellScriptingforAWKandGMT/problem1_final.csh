#!/bin/csh
set inputfile = "fmdata.txt"

# In this script we are going to plot the focal mechanism in a global scale with Hammer projection
# pscoast command to plot continents, shorelines, rivers and borders
# -JH will do the Hammer projection
# -X, -Y Shift plot origin relative to the current origin and 
# c is to center the plot on the center of the paper, -Rd, region of interest(here global)
# -P, to make it portarit; -K, not to finalize the postscript plot; -D, resolution (f for full)
echo "Plotting continents, shorelines, rivers and borders..."
pscoast -Xc -Yc -Rg -JH5i -Bg30/g30:."Global Focal Mechanism": -Gbisque -Sskyblue -Df -P -K > fq.ps

# AWK will change the txt data file's format and 'll arrange it in a new organized format as
# lon lat dep mrr mtt mpp mrt mrp mtp exp lon1 lat1
echo "AWK is changing the format of the txt file.."
awk '{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' $inputfile >> gm.txt

# psmeca will plot focal mechanisms on maps, -Rg stands for global domain 
# psbasemap plots PostScript base maps
# (-180/+180 in longitude respectively, with -90/+90 in latitude)
# -Sc specifies focal mechanisms in Harvard CMT convention
echo "Plotting Focal Mechanism on map..."
psmeca gm.txt -Rg -JH5i -Sm0.15i -P -O -K >> fq.ps
psbasemap -R-180/180/-90/90 -JH5i -B10/10 -K -O -P >> fq.ps

# pslegend will plot a map legend. -D to position the legend and specify the size
# (-Dx) to specify the position in map plot units; -F to draw a box
pslegend << END -Rg -JH5i -Dx0.25i/3.75i+w1.05i/1.05i+jLB -F+gwhite+p1p,black -O -P >> fq.ps
G 0.05i
S 0.15i c 0.25i - black 0.4i M = 9
G 0.05i
S 0.15i c 0.15i - black 0.4i M = 7
G 0.05i
S 0.15i c 0.12i - black 0.4i M = 5
END

# psconvert to convert the plot into pdf, rm to remove the .ps file
psconvert -A0.1i -Tf fq.ps
rm -f fq.ps
