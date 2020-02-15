#!/usr/bin/env bash

BREW="${1}"
OUT="${2}"

echo "" > "${OUT}"

if [[ -z "${OUT}" ]] || [[ -z "${BREW}" ]];then
  echo "bad syntax:  ./<script> <brew> <out_file>"
  exit 1
fi

H1=""
H2=""

CHAPTER_COUNT=0

while IFS= read -r line;do
  if egrep -q "^[[:space:]]*# " <(echo "${line}");then
    H2=""
    H1="$(echo "${line}" | sed 's/# //g;s/<[^>]*>//g')"
    CHAPTER_COUNT=$(( CHAPTER_COUNT + 1 ))
    cat <(echo "${line}") >> "${OUT}"
  elif egrep -q "^[[:space:]]*## " <(echo "${line}");then
    H2="$(echo "${line}" | sed 's/## //g;s/<[^>]*>//g')"
    cat <(echo "${line}") >> "${OUT}"
  elif egrep -q "[[:space:]]*\\page[[:space:]]*$" <(echo "${line}");then
    if [[ -n "${H1}" ]] && [[ -n "${H2}" ]];then
      echo "why"
      echo "<div class='footnote'>PART ${CHAPTER_COUNT} | ${H1^^} | ${H2^^}</div>" >> "${OUT}"
    elif [[ -n "${H1}" ]] && [[ -z "${H2}" ]];then
      echo "<div class='footnote'>PART ${CHAPTER_COUNT} | ${H1^^}</div>" >> "${OUT}"
    fi
    echo '\page' >> "${OUT}"
  else
    cat <(echo "${line}") >> "${OUT}"
  fi
done < "${BREW}"

