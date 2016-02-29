#!/bin/bash

#PDFIMAGES=/home/harald/Downloads/Software/xpdfbin-linux-3.04/bin64/pdfimages
PDFIMAGES=pdfimages

for f in ./*.pdf; do
    nbr=$(echo $f | cut -d"-" -f1)
    dir=extracted_images/$nbr
    
    mkdir $dir
    $PDFIMAGES $f $dir/$nbr
done
