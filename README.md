# audio-badify
You can make audio files sound bad with these ```ffmpeg``` args
<pre>-ar 22050 -b:a 1k</pre>
or
<pre>-ar 8000 -b:a 100</pre>

## Usage:
```-h | --help``` Print help output.

```-m | --mode``` Select badify mode, currently 1 (22.5Khz), or 2 (8Khz).

```     --exec``` Pass an ffmpeg executable

```-y         ``` Make ffmpeg assume yes (Pass ```-y``` for overwrite, etc)
