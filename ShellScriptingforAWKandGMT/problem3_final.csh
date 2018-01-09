#!/bin/csh
# In this script we will plot a seismic hazard map for 2014 
# with 2% excedence in 50 years on an Albers Conic Projection

# First,convert the scattered XYZ data into a grid file, data.grd
# xyz2grd is to convert data, -R to pecify region (continental USA)
# -I for grid spacing, here 0.05
echo "Converting the XYZ data into grid file.."
xyz2grd 2014_pga2pct50yrs.dat -Gdata.grd -R-130/-60/24.6/50 -I0.05 

# Second, convert the grid file, data.grd to color palette
# match the color scale to range of data using grd2cpt
# -Chot, to choose color as hot, -I, to reverse the sense of color progression. 
# -Z, to create a continuous color palette.
echo "Converting the grid file into color palette.."
grd2cpt data.grd -Chot -I -Z  > hotcolor.cpt 

# Third, plot the gridded data with color pallete and Albers Conic Map projection 
# -JB to specify conic projection. 
echo "Plotting the gridded data.."
grdimage data.grd -Chotcolor.cpt -Xc -Yc -R -JB-97/35/33/45/7i -Q -P -K >p3.ps

# Next, draw contour intervals on the color image using grdcontour.
echo "Drawing contour interval.."
grdcontour data.grd -C0.4 -J -R -Wdarkgray -A- -P -O -K >>p3.ps

# Now, Draw the coastlines over -R 
# Draw country boundary using N1 
# Draw the state boundaries using N2 
# select skyblue for all water bodies
echo "Drawing coastlines,country/state boundaries.." 
pscoast -R -J -B10:."US 2014 Earthquake Hazard Map": -N1/thick -N2 -Df -W -Sskyblue -P -K -O >>p3.ps

# Finally, draw the color bar at a location specified by -D, x and y distance 
# from the lower corner and width = 2.5 in and height = 0.25 in 
# h will make it horizontal
echo "Drawing the color bar..."
psscale -D3.5i/-.75i/2i/0.25ih -Chotcolor.cpt -Ba.3:"PGA value": -P -O >> p3.ps 

# convert the output file into pdf file and remove the .ps file

psconvert -A0.1i -Tf p3.ps
rm -f p3.ps
rm -f gmt.history
