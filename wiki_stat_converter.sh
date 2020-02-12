#!/usr/bin/env bash

_echo(){
  echo "${1}" | tr '[:upper:]' '[:lower:]'
}

while read line;do
  if [[ "${line}" =~ ^Built.* ]];then
    _echo "${line}" | sed 's/built by[[:space:]]*/built_by: /'
  fi
  if [[ "${line}" =~ ^Used.* ]];then
    _echo "${line}" | sed 's/used primarily by[[:space:]]*/used_primarily_by: /'
  fi
  if [[ "${line}" =~ ^Cost.* ]];then
    _echo "${line}" | sed 's/cost[[:space:]]*/cost: /'
  fi
  if [[ "${line}" =~ ^Tonnage.* ]];then
    _echo "${line}" | sed 's/tonnage[[:space:]]*/tonnage: /'
  fi
  if [[ "${line}" =~ ^Hull.* ]];then
    _echo "${line}" | sed 's/hull points[[:space:]]*/hull_points: /'
  fi
  if [[ "${line}" =~ ^Crew.* ]];then
    _echo "${line}" | sed 's/crew (min\/max)[[:space:]]*/crew: /'
  fi
  if [[ "${line}" =~ ^Man-Days.* ]];then
    _echo "${line}" | sed 's/man-days of fresh air[[:space:]]*/man_days_fresh_air: /'
  fi
  if [[ "${line}" =~ ^Maneuver.* ]];then
    _echo "${line}" | sed 's/maneuver class[[:space:]]*/maneuver_class: /'
  fi
  if [[ "${line}" =~ ^Landing - Land ]];then
    _echo "${line}" | sed 's/landing[[:space:]]*/: /'
  fi
  if [[ "${line}" =~ ^ ]];then
    _echo "${line}" | sed 's/[[:space:]]*/: /'
  fi
  if [[ "${line}" =~ ^ ]];then
    _echo "${line}" | sed 's/[[:space:]]*/: /'
  fi
  if [[ "${line}" =~ ^ ]];then
    _echo "${line}" | sed 's/[[:space:]]*/: /'
  fi
  if [[ "${line}" =~ ^ ]];then
    _echo "${line}" | sed 's/[[:space:]]*/: /'
  fi

done

#Built By	Orcs
#Used Primarily By	Orcs
#Cost	99,000 gp
#Tonnage	30 tons
#Hull Points	60
#Crew (Min/Max)	4/30 (total weapon crew: 7)
#Man-Days of Fresh Air	3,600
#Maneuver Class	C
#Landing - Land	Yes
#Landing - Water	No
#Armour Rating	4
#Saves As	Metal
#Power Type	Major helm (20%), minor helm (20%), lifejammer (60%)
#Ship's Rating	As per helmsman or victim
#Standard Armament	Piercing Ram
#1 Medium Ballista (crew: 2)
#1 Medium Catapult (crew: 1)
#2 Ram-Claws (crew: 1)
#
#Cargo	6 tons
#Keel Length	150'
#Beam Length	40'
#Source	SJR1 Lost Ships
