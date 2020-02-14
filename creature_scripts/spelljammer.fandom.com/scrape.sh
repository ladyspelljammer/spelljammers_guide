#!/usr/bin/env bash
IFS='\n'

BASE_URL="https://spelljammer.fandom.com/"
CREATURES="$(curl -s "${BASE_URL}/wiki/Category:Spelljammer_creatures" | pup '.category-page__member-left a attr{href}')"

PAGE="${1}"
NAME="$(echo "${PAGE}" | sed 's/.*\///g')"
IMAGE="$(curl -s "${PAGE}" | pup '.WikiaMainContent' | pup 'figure a attr{href}' | grep "https" | sed 's/\/revision.*//g' | sed 's/^[[:space:]]*//g;s/[[:space:]]*$//g')"

STATS="$(curl -s "${PAGE}" | pup '#mw-content-text .wikitable:first-of-type' | ./parse_table.rb | ./csv2yaml.rb 2>/dev/null)"

IS_TABLE=false
LOOP=true

HTML="$(curl -s "${PAGE}" | pup '#mw-content-text' | while read line;do
  if echo "$line" | grep -qi '<table' && ${LOOP};then
    IS_TABLE=true
  fi

  if ! ${IS_TABLE};then
   echo "${line}"
  fi

  if echo "$line" | grep -qi '</table' && ${LOOP};then
    IS_TABLE=false
    LOOP=false
  fi
done
)"


echo "${NAME,,}:"
#echo "$HTML"  | pup '#mw-content-text' | html2text -width 100000 | sed 's/.//g' | sed 's/[[:space:]]*\[data.*\].*Edit//g' | grep -v "stylesheet\|Retrieved from \" \|Categories\|*  Spelljammer creatures\|*  Add category\|Cancel   Save\|Community content is available\|***** Contents\|\[ show \]" | sed 's/^\([a-zA-Z0-9].*\)/    \1/g' | sed 's/.*2nd Edition Stats.*/  stats:/g' | sed 's/[[:space:]]*\*\*\*\**$/: \|/g' | sed 's/^\*\*\*\**[[:space:]]*/  /g' | sed 's/^[[:space:]]*\*[[:space:]]*/    /g' | grep -v "^[[:space:]]*\[.*\][[:space:]]*$\|^[[:space:]]*$" | sed '1 i\  summary:'
echo "$HTML"  | pup '#mw-content-text' |  html2text -width 100000 | sed 's/.//g' | sed 's/[[:space:]]*\[data.*\].*Edit//g' | grep -v "stylesheet\|Retrieved from \" \|Categories\|*  Spelljammer creatures\|*  Add category\|Cancel   Save\|Community content is available\|***** Contents\|\[ show \]" | sed 's/^\([a-zA-Z0-9].*\)/    \1/g' | sed 's/.*2nd Edition Stats.*/  Stats:/g' | sed 's/[[:space:]]*\*\*\*\**$/: \|/g' | sed 's/^\*\*\*\**[[:space:]]*/  /g' | sed 's/^[[:space:]]*\*[[:space:]]*/    /g' | grep -v "^[[:space:]]*\[.*\][[:space:]]*$\|^[[:space:]]*$" | sed '1 i\  Summary:' | sed 's/^[[:space:]]*\([0-9]*\. \)/    \1/g' | sed 's/Religio:/Religion:/g;s/Descriptio:/Description:/g;s/ \.$/\./g;s/References: |/References:/g' | grep -v "/revision/latest/scale-to-width-down" | while read line;do
  if echo "${line}" | grep -qi "Stats:";then
    echo "${line}"
    [[ -n "${STATS}" ]] && echo "${STATS}"
  else
    echo "${line}"
  fi
done

echo "  Images:"
echo "    ${IMAGE}"
