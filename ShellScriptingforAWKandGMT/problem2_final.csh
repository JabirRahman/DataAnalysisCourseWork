#!/bin/csh
# In this script we will plot GPS velocities for the Parkfield section of the San Andreas Fault on a Mercator projection. 

# grdraster, to extract subregion from a binary raster and save as a GMT grid file
# -G, to specify name of output grid file; -I, to specify the grid spacing (increment)
echo "Setting up the sub-region..."
grdraster 11 -R-121/-119.5/35.4/36.2 -I0.5m -Gfctopo.grd 

# grd2cpt creates color palette using the gird data. -C to Select the master color table to use in the interpolation. -Z, to create a continuous color palette; -D, to Select the back and foreground colors to match the colors for lowest and highest z-values in the output CPT 
echo "Creating color pelette using grid data... "
grd2cpt fctopo.grd -Cgray -Z -Df > fctopo.cpt 

# grdgradient calculates the grid gradient for illuminating in the specified direction; -A, to specify Azimuthal direction for a directional derivative; -G, output file name; -Ne, to normalize using a cumulative Laplace distribution
echo "Calculating the grid gradient.."
grdgradient fctopo.grd -A345 -Gfctopo.intns -Ne0.6

# grdimage, to project grids and to plot them on maps. -I, to Give the name of a grid file with intensities in the (-1,+1) range;
# -C, to specify name of the cpt file; other varibales are as previous problem.
echo "Ploting the grid data on map..." 
grdimage fctopo.grd -Ifctopo.intns -Cfctopo.cpt -Xc -Yc -JM5i -R -P -K > p2.ps 

# pscoast draws the coast lines, water boundries and centers the map; -B, to set map boundary frame and axes attributes
# (a is used to specify the annotation and major tick spacing, g for gridline spacing); -D, to select the resolution of the data set to use(f, for full); -W, to Draw shorelines;      
echo "Drawing the GPS velocities in the Parkfield Area" 
pscoast -J -R -Ba.5g.5:."GPS velocities-Parkfield Area": -Df -W -P -O -K >> p2.ps

# Awk is to format the kml file in the desired ouput as XY file. psxy to Plot lines, polygons, and symbols on maps.
# -J, to select map projection. -W, to set pen attributes for lines or the outline of symbols (2p to specify thickest); 
echo "AWK is reformating the kml file.."
awk 'BEGIN {FS = ","}/(^-)|(<LineString)/ {print $0}' Historic.kml | \
awk 'BEGIN {RS = "</coordinates>"; ORS=">\n"} {i= match($0,/-/); print substr($0,i)}' | \
psxy -J -W2p,red -R -P -O -K >> p2.ps

# psvelo to plot GPS velocity vectors using the file parkfield velocity.txt; -J, to select map projection;
# -Se(velscale, to set the scaling of the velocity arrows; confidence, to set the 2-dimensional confidence limit;
# fontsize, to set the size of the text in points 
echo "Plotting GPS Velocity vectors..."
psvelo parkfieldvel.txt  -J -Se0.009i/0.95/5 -W -R -P -O >> p2.ps

# covert file to pdf and get rid of .ps file and gmt history
echo "Converting file into pdf.. "
psconvert -A0.1i -Tf p2.ps
rm -f p2.ps
rm -f gmt.history
