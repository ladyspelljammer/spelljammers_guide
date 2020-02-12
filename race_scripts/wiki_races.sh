#!/bin/bash

RACES=( $(curl -sL http://spelljammer.wikia.com/wiki/Category:Spelljammer_creatures | pup '#mw-pages table a' | grep href | sed 's/.*wiki\///g;s/".*//g') )

echo ${RACES[0]}
