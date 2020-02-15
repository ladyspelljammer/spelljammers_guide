#!/usr/bin/env bash

BREW="${1}"


if [[ -z "${BREW}" ]];then
  echo "bad syntax:  ./<script> <brew>"
  exit 1
fi

H1=""
H2=""
H3=""

PAGE_COUNT=0
PAGE_COUNT_OFFSET=1

PAGE_COUNT=$(( PAGE_COUNT - PAGE_COUNT_OFFSET ))

echo "<div class='toc'>"

while IFS= read -r line;do
  if egrep -q "^[[:space:]]*# " <(echo "${line}");then
    H2=""
    H3=""
    H1="$(echo "${line}" | sed 's/# //g;s/<[^>]*>//g')"
    echo "- ### [<span>${PAGE_COUNT}</span><span>**${H1}**</span>](#p${PAGE_COUNT})"
  elif egrep -q "^[[:space:]]*## " <(echo "${line}");then
    H3=""
    H2="$(echo "${line}" | sed 's/## //g;s/<[^>]*>//g')"
    echo " - #### [<span>${PAGE_COUNT}</span><span>**${H2}**</span>](#p${PAGE_COUNT})"
  elif egrep -q "^[[:space:]]*### " <(echo "${line}");then
    H3="$(echo "${line}" | sed 's/### //g;s/<[^>]*>//g')"
    if ! egrep -q  "Officer Actions|Officer Reactions|Features" <(echo "${H3}");then
      echo "   - [<span>${PAGE_COUNT}</span><span>${H3}</span>](#p${PAGE_COUNT})"
    fi
  elif egrep -q "[[:space:]]*\\page[[:space:]]*$" <(echo "${line}");then
    PAGE_COUNT=$(( PAGE_COUNT + 1 ))
  fi
done < "${BREW}"

echo "</div>"
