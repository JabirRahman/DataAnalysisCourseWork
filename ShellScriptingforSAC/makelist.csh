#!/bin/csh
# Our target is to automate the process as much as possible. So rather than putting the station name manually
# we are trying to make the script automatic so that it can take any number of stations as the input and
# make a txt file containing a list of only the North and East components

# copy raw data from the original download folder to the current directory to not mess with the original data
cd ~/Downloads/wbeq/
cp * ~/Public/DataAnalysisHomeWork/FourthHomeWork/

# Go back to current directory
cd ~/Public/DataAnalysisHomeWork/FourthHomeWork/

# The first command will make a list of only the north components of each station, make it as the input for
# for akk and save it as a list of north components as a txt file named north.txt
ls -1 *BHN*.SAC | awk '/BHN/ { print $0 }' > north.txt

# Same as the first command, just the component is changed as East component
ls -1 *BHE*.SAC | awk '/BHE/ { print $0 }' > east.txt

# We need a single list to easily handle our commands later. So, the next command will marge both the txt
# files and make a single txt file containing only the north and south components from each stattion
paste east.txt north.txt > EN.txt

# We can check the list using cat command
cat EN.txt

# Check if the files are emapty or not, in both cases, the script will throw a message
if (`ls -l *.SAC | awk '{ print $5 }'` == $0 ) then
    echo "You did something wrong. Files are empty. Please check back..."
else
    echo "You are on the right track. Carry on...."
endif

# Once we made our final list of components, we don't need the single two files containing 
# One of the two components separately. So, get rid of the two single lists here
rm north.txt
rm east.txt
