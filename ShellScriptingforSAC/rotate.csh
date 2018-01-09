#!/bin/csh
# This script will carry on some works on sac. Once we have our table from the first script contatining
# onlt north and east components, we can read two components for each of the stations and rotate them
# to great circle path

# To read two components from the same station, we need to assign a specific number to each station. Thus
# the shell will recognize to read only that two at a time and not some other component from another station

# Set East component to E and North component to N. This way we can easily handle them.
set E=`cat EN.txt|awk '{print $1}'`
set N=`cat EN.txt|awk '{print $2}'`

# Initiate a value for the variable $line. So that we can keep track of our table of data
set line = 1

# Execute a while loop so that the shell go for each line in the table, read both components 
# for the same station and do the other processing
while ($line <= $#E)
sac <<EOF

# cut the data to a desired length                                                  
cut  0 3000

# read each line and both components of that line according to the number of $E
read $E[$line] $N[$line]

# Execute low pass filter to filter out the higher frequencies higher than 0.1
# We are using a lowpass butterworth filter here
#lp bu c 0.1

# Or decimate it multiple times. Decimate gives better plot, let's keep that
decimate 4
decimate 3
decimate 2
decimate 5

# Rotate both component to great circle path. North component to Radial and 
# East component to Trasverse 
rotate to GCP

# write over all the files with new files. It will replace the old N E 
# components with new rotated components
write over

# quit  and exit SAC each time the shell loops over
quit
EOF

# keep track of line number, increase it by one each time
set line=`expr $line + 1`

# End the loop when the processing for all stations is completed
end
