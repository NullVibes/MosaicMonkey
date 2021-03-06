# MosaicMonkey
MosaicMonkey is a quick shell script for `bash` that builds video mosaic files used with [VLC Media Player](https://www.videolan.org/).  The output format is in the VideoLan Manager file format.  More information can be found on [wiki.videolan.org](https://wiki.videolan.org/Documentation:Streaming_HowTo/VLM/).

***Currently built for MacOS, but working on 'nix, too!***


 ## Installation ##
The files in this repository can be run directly.

Ensure [VLC](https://www.videolan.org/) is installed.

Once downloaded, simply run `./mosaicmonkey` with the camera numbers \(in the script\) to build/launch the mosaic file. 

Example:

`./mosaicmonkey 1 5 7 9`

This example launches the script that builds a mosaic file for camera streams 1, 5, 7 & 9, then launches VLC for viewing.

To add/change camera streams, simply edit the `mosaicmonkey.sh` script.
Video streams from public webcams can be easily found using the [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/) web browser, and using the built-in ***Developer Tools***, under the ***Network*** tab. \(Check for file names ending in ***.m3u8***.)

## Output ##
The resulting output of the script is written to a `mosaicMonkey.vlm` file, then VLC is automatically launched.

\(This is done for you by the script.\)

`./VLC --vlm-conf /Users/username/Downloads/mosaicMonkey.vlm`
