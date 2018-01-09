# This is a test script to check if we can combine all
# the shell scripts. If we can then we won't need to 
# separately execute each script rather we just execute
# one master script to run all the intermadiate scripts
# Let's try this

#!/bin/csh 
# clear the directory
csh cleandir.csh

# make the list of two components East and north
csh makelist.csh

# Rotate both components to Great circle path
csh rotate.csh

# Process Z component
csh processZ.csh

# Almost done, do the final execution on all three components
csh execute.csh

# clean the command window
clear

echo "Thank You ERIC for your time and help. You are the best..."
