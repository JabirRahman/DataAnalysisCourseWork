#This script is used to process the Z components from each station
#!/bin/csh
# cut data to a desired length
cut 0 3000

sac <<EOF
# read the Z component for each station here
read *BHZ*.SAC

# Execute low pass filter to filter out the higher frequencies higher than 0.1 
# We are using a lowpass butterworth filter here                     
#lp bu c 0.1 n 2 p 1 

# In my case decimate worked better, let's keep decimate rather than low pass
decimate 4
secimate 3
decimate 2
decimate 5
decimate 4
# write over the modified Z components 
write over

# quit sac
quit
EOF
