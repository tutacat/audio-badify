EXEC="ffmpeg"
YYY=""
MODE=1

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo -e "Audio Badify script (ffmpeg) usage.\n\naudio-badify -[m] <input> <output>-h\t--help\tShow this help.\n-m\t--mode\tBadify mode, currently 1 (22.5Khz), or 2 (8Khz)\n\t--exec\tSpecify the ffmpeg executable\n-y\t\tffmpeg assume yes (overwrite, etc.)"
    shift
    shift
    ;;
    -m|--mode)
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
    shift
    ;;
esac
done
set -- "${POSITIONAL[@]}"

if [ ${MODE} -eq 1 ] then
    ${EXEC} -i "$1" -ar 22050 -b:a 1k ${YYY} "$2"
elif [ ${MODE} -eq 2] then
    ${EXEC} -i "$1" -ar 8000 -b:a 100 ${YYY} "$2"
fi
