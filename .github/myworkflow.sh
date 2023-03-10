#!/bin/bash
echo "Checking hash..." >&2
if sha256sum audio-badify.sh | ! diff -q - _hash; then
  echo "Script changed." >&2 
  if ! which ffmpeg >/dev/null; then 
    echo "Installing ffmpeg..." >&2
    sudo snap install ffmpeg
    if [ "$?" -gt 0 ] ; then
      echo "Installing ffmpeg failed." >&2
      exit 126
    fi
  fi
  echo "Running..." >&2
  bash audio-badify.sh -y example.mp3 example-bad.mp3
  if [ "$?" -gt 0 ] ; then
    echo "Run failed. (code "$?")" >&2
    exit 2
  fi
  echo Testing help... >&2
  bash audio-badify.sh -h
  if [ "$?" -gt 0 ] ; then
    echo "Help failed. (code "$?")" >&2
    exit 2
  fi
  echo Testing none... >&2
  ! bash audio-badify.sh nothing.mp3 nothing-bad.mp3
  if [ "$?" -gt 0 ] ; then
    echo "Failed test for nonexistent file. (code "$?")" >&2
    exit 2
  fi
  echo Testing dir as a... >&2
  mkdir dir
  ! bash audio-badify.sh dir dir-bad.mp3
  if [ "$?" -gt 0 ] ; then
    echo "Failed test for dir as a. (code "$?")" >&2
    exit 2
  fi
  echo Testing dir as b... >&2
  ! bash audio-badify.sh example.mp3 dir
  if [ "$?" -gt 0 ] ; then
    echo "Failed test for dir as b. (code "$?")" >&2
    exit 2
  fi
  echo Updating hash... >&2
  sha256sum audio-badify.sh > _hash
  git add _hash
  git commit -m 'Workflow: Update hash'
  git push
else
  echo "Script unchanged." >&2
fi
echo Done. >&2
exit 0
