#!/bin/bash

# removing old files.
rm -f ff.g
rm -f rt*

rt=rtFile

cat <<EOF | mged -c ff.g
in s rcc 4 0 0 0 1 0 2
in s1 rpp 1 2 0 5 0 1
in s2 rpp 6 7 0 5 0 1
in s3 rcc 1 4 .5 1 0 0 .4
in s4 rcc 6 4 .5 1 0 0 .4 
in s5 rcc 4 0 0 0 1 0 2  

r reg u s u s1 u s2 
r reg1 u reg - s3 - s4 - s5 
mater reg1 plastic 255 0 0 0
B reg1 
ae 115 310
saveview $rt
EOF

# give executable permissions to raytrace file.
chmod 755 $rt

# executing raytrace file. This will produce raw image in .pix format
# and a log
#file.
sh $rt

# converting .pix file to png image using BRLCAD commands.
pix-png < $rt.pix > $rt.png

# open png image in a frame buffer. Currently not required.
#env /usr/brlcad/bin/png-fb $rt.png

shotwell $rt.png
