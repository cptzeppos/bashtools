#!/bin/bash
sed 's/\\/\\\\/g'  frei.txt  | awk 1 ORS='\\n' >out.txt
inhalt=$(<out.txt)
echo "$inhalt"
cp musta.txt neu.txt
sed -i "s@PANOPLIA@${inhalt}@" neu.txt
