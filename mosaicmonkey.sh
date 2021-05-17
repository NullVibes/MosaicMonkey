#!/bin/bash

clear
echo "#######################################################"
echo "#  VLC Video Mosaic Maker - (Multiple Video Streams)  #"
echo "#          Output from ./mosaicmonkey script          #"
echo "#                  Credit: NullVibes                  #"
echo "#######################################################"

camNum1=("I-526W @MM 13.5" "https://s18.us-east-1.skyvdn.com/rtplive/60055/chunklist_w71830261.m3u8")
camNum2=("I-526 W@MM11" "https://s20.us-east-1.skyvdn.com/rtplive/60040/chunklist_w1214649608.m3u8")
camNum3=("I-26 W @ MM 220" "https://s20.us-east-1.skyvdn.com/rtplive/60063/chunklist_w782300799.m3u8")
camNum4=("US 17 N Ravenel Bridge @ SC 703 Mt Pleasant" "https://s20.us-east-1.skyvdn.com/rtplive/60069/chunklist_w1637215508.m3u8")
camNum5=("US 17 S Ravenel Bridge @ Charleston Tower - Lower" "https://s20.us-east-1.skyvdn.com/rtplive/60077/chunklist_w2005319066.m3u8")
camNum6=("US 17 S Ravenel Bridge @ Mt. Pleasant Tower Lower" "https://s18.us-east-1.skyvdn.com/rtplive/60075/chunklist_w1491111268.m3u8")
camNum7=("US 17 S Ravenel Bridge @ Charleston Tower - Upper" "https://s18.us-east-1.skyvdn.com/rtplive/60078/chunklist_w759617998.m3u8")
camNum8=("I-26 E @ MM 220" "https://s19.us-east-1.skyvdn.com/rtplive/60062/chunklist_w1907559901.m3u8")
camNum9=("US 17 S Ravenel Bridge @ Charleston Tower - Lower" "https://s20.us-east-1.skyvdn.com/rtplive/60077/chunklist_w2005319066.m3u8")
camNum10=("SC 517 IOP Connector @ Rifle Range Rd" "https://s20.us-east-1.skyvdn.com/rtplive/60077/chunklist_w1042145373.m3u8")
camNum11=("SC 517 IOP Connector @ SC 703" "https://s18.us-east-1.skyvdn.com/rtplive/60075/chunklist_w10504269.m3u8")

totalCams=$#
if [[ $# -lt 1 ]]; then
	echo ""
	echo "No cameras selected!  Aborting."
	echo ""
	exit 0
else
	echo ""
	echo "$totalCams cameras selected."
	echo ""
fi

workingDir="$(pwd)"
file="mosaicMonkey.vlm"
if [ -f "$workingDir/$file" ]; then
	echo -e "Clearing previous config..."
	printf "" > $workingDir\/$file
	echo ""
else
	echo "Creating new config."
	touch $workingDir\/$file
fi

bgImage="1920x1080black.png"
if [ -f "$workingDir/$bgImage" ]; then
	echo "Background image found."
else
	echo "Downloading background image."
	#curl -LJO https://github.com/NullVibes/MosaicMonkey/blob/cca57e35045b058339ddeaa0a4b3265e8743b056/1920x1080black.png
fi

echo "#######################################################" >> $workingDir\/$file
echo "#  VLC Video Mosaic Maker - (Multiple Video Streams)  #" >> $workingDir\/$file
echo "#          Output from ./mosaicmonkey script          #" >> $workingDir\/$file
echo "#                  Credit: NullVibes                  #" >> $workingDir\/$file
echo "#######################################################" >> $workingDir\/$file
echo "del all" >> $workingDir\/$file

counter=0
ctrlPlay=""
tcode="setup bg output #transcode{vcodec=mp4v,vb=0,fps=0,acodec=none,channels=$totalCams,sfilter=mosaic{alpha=255,width=1280,height=1080,cols=2,rows=2,position=1,order=\""
while [ $counter -lt $totalCams ]; do
	let counter+=1
	camArray="camNum$1[1]"
	echo "" >> $workingDir\/$file
	echo "new ch$counter broadcast enabled" >> $workingDir\/$file
	echo "setup ch$counter input ${!camArray}" >> $workingDir\/$file
	echo "setup ch$counter output #mosaic-bridge{id=ch$counter,width=512,height=512}" >> $workingDir\/$file
	ctrlPlay="${ctrlPlay}control ch$counter play\n"
	if [[ $counter -eq $totalCams ]]; then
		tcode="${tcode}ch$counter"
	else
		tcode="${tcode}ch$counter,"
	fi	
	shift
done

echo "" >> $workingDir\/$file
echo "new bg broadcast enabled" >> $workingDir\/$file
echo "setup bg input \"1920x1080black.png\"" >> $workingDir\/$file
echo "setup bg option image-duration=-1" >> $workingDir\/$file

tcode="${tcode}\",keep-aspect-ratio=enabled,mosaic-align=0,keep-picture=1}}:bridge-in{offset=100}:display"
echo $tcode >> $workingDir\/$file
echo "" >> $workingDir\/$file
echo "control bg play" >> $workingDir\/$file
echo -e $ctrlPlay >> $workingDir\/$file
echo "" >> $workingDir\/$file
echo "# END OF MOSAICMONKEY" >> $workingDir\/$file

app="vlc"
macLoc="/Applications/VLC.app/Contents/MacOS"
if [ -f "$macLoc/$app" ]; then
	($macLoc/./VLC --vlm-conf $workingDir/$file)
else
	echo "Uh oh... Error opening VLC!"
fi