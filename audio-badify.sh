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
    if [ ! "$a" ]; then a="$1"; else b="$(echo "$1"|sed 's/\\.ogg$/\\.mp3/')"; fi
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}"
if [ ! -e "$a" ]; then
  echo $a: No such file or directory.
  exit 1
elif [ -d "$a" ]; then
  echo $a: Is a directory.
  exit 1
fi
if [ -d "$b" ]; then
  echo echo $b: Is a directory.
fi
if [ ! -z "$a" ] && [ ! -z "$b" ]; then
  echo yes
  if [ ${MODE} -eq 1 ]; then
    echo mode 1
    ${EXEC} -i "$a" -ar 22050 -b:a 1k ${YYY} "$b.mp3"
  elif [ ${MODE} -eq 2 ]; then
    echo mode 2
    ${EXEC} -i "$a" -ar 8000 -b:a 500 ${YYY} "$b.mp3"
  else
    echo "Incorrect mode specified"
  fi
fi

exit 0
