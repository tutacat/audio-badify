# audio-badify
[![](https://github.com/tutacat/audio-badify/actions/workflows/tests.yml/badge.svg)](https://github.com/tutacat/audio-badify/actions/workflows/tests.yml)  
«Audio is too good?»
DL (save as) https://raw.githubusercontent.com/tutacat/audio-badify/master/audio-badify.sh<br>
run `bash audio-badify.sh` or `zsh audio-badify.sh`
### Usage:
````
audio-badify [-m n] <input> <output>
 -h  --help  Print this help.
 -m  --mode  Select badify mode, currently 1 (22.5Khz), or 2 (8Khz).
     --exec  Pass an ffmpeg executable
 -y          Make ffmpeg assume yes (Pass -y for overwrite, etc)
 ````
### How it works
You can make audio files sound bad with these ```ffmpeg``` args

    -ar 22050 -b:a 1k
    
or

    -ar 8000 -b:a 100


