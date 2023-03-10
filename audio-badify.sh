EXEC='ffmpeg'
YYY=''
MODE=1
POSITIONAL=

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -h|--help)
    echo "$@"
    echo -e "Audio Badify script (ffmpeg) usage.\n\naudio-badify -[m] <input> <output>\n-h  --help  Show this help.\n-m  --mode  Badify mode, currently 1 (22.5Khz), or 2 (8Khz)\n    --exec  Specify the ffmpeg executable\n-y          ffmpeg assume yes (overwrite, etc.)"
    exit 0
    shift
    ;;
    -m|--mode)
    echo "$@"
    MODE=$2
    shift 2
    ;;
    --exec)
    EXEC="$2"
    shift 2
    ;;
    -y)
    YYY="-y"
    shift
    ;;
    *)
    if [ ! "$a" ]; then a="$1"; else b="$(echo "$1"|sed 's/\.ogg$/\.mp3/')"; fi
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}"
[ ! -e "$a" ] && echo $a: No such file or directory. >&2
[ -d "$a" ] && echo $a: Is a directory. >&2
[ -d "$b" ] && echo $b: Is a directory. >&2
if [ ! -e "$a" -o -d "$a" -o -d "$b" ]; then exit 2; fi
if [ ! -z "$a" ] && [ ! -z "$b" ]; then
  echo yes
  if [ ${MODE} -eq 1 ]; then
    echo mode 1
    ${EXEC} -i "$a" -ar 22050 -b:a 1k ${YYY} "$b"
  elif [ ${MODE} -eq 2 ]; then
    echo mode 2
    ${EXEC} -i "$a" -ar 8000 -b:a 500 ${YYY} "$b"
  else
    echo "Incorrect mode specified"
  fi
fi

exit 0
