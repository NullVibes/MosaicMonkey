# MosaicMonkey
MosaicMonkey is a quick shell script for `bash` that builds video mosaic files used with [VLC Media Player](https://www.videolan.org/).

***Currently built for MacOS, but working on 'nix, too!***

 ### Installation ###
The files in this repository can be run directly.

Ensure [VLC](https://www.videolan.org/) is installed.

Once downloaded, `chmod +x` the script.  Then, simply run ./mosaicmonkey with the camera numbers \(in the script\) to build/launch the mosaic file. 

Example:

`chmod +x mosaicmonkey.sh`

`./mosaicmonkey 1 5 7 9`

This example launches the script that builds a mosaic file for camera streams 1, 5, 7 & 9, then launches VLC for viewing.

To add/change cameras, simply edit the `mosaicmonkey.sh` script.
