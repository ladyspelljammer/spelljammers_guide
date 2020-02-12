#!/usr/bin/env bash

BASE_URL="https://spelljammer.fandom.com/"
CREATURES="$(curl -s "${BASE_URL}/wiki/Category:Spelljammer_creatures" | pup '.category-page__member-left a attr{href}')"

PAGE="${1}"
NAME="$(echo "${PAGE}" | sed 's/.*\///g')"
IMAGE="$(curl -s "${PAGE}" | pup '.WikiaMainContent' | pup 'figure a attr{href}' | grep "https" | sed 's/\/revision.*//g' | sed 's/^[[:space:]]*//g;s/[[:space:]]*$//g')"

echo "${NAME,,}:"
curl -s "${PAGE}" | pup '.WikiaMainContent' | html2text -width 100000 | sed 's/.//g' | sed 's/[[:space:]]*\[data.*\].*Edit//g' | grep -v "stylesheet\|Retrieved from \" \|Categories\|*  Spelljammer creatures\|*  Add category\|Cancel   Save\|Community content is available\|***** Contents\|\[ show \]" | sed 's/^\([a-zA-Z0-9].*\)/    \1/g' | sed 's/.*2nd Edition Stats.*/  stats: \|/g' | sed 's/[[:space:]]*\*\*\*\**$/: \|/g' | sed 's/^\*\*\*\**[[:space:]]*/  /g' | sed 's/^[[:space:]]*\*[[:space:]]*/    /g' | grep -v "^[[:space:]]*\[.*\][[:space:]]*$\|^[[:space:]]*$" | sed '1 i\  summary:'
echo "  image: ${IMAGE}"
