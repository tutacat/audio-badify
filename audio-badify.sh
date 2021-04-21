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
    exit 1
    shift
    ;;
    -m|--mode)
    echo "$@"
    MODE=$2
    shift
    shift
    ;;
    --exec)
    EXEC="$2"
    shift
    shift
    ;;
    -y)
    YYY="-y"
    shift
    ;;
    *)
    POSITION+=("$1")
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}"
if [ ! -z $1 ] && [ ! -z $2 ]; then
  echo yes
  if [ ${MODE} -eq 1 ]; then
    echo mode 1
    ${EXEC} -i "$1" -ar 22050 -b:a 1k ${YYY} "$2"
  elif [ ${MODE} -eq 2 ]; then
    echo mode 2
    ${EXEC} -i "$1" -ar 8000 -b:a 100 ${YYY} "$2"
  else
    echo "Incorrect mode specified"
  fi
fi

exit 1
