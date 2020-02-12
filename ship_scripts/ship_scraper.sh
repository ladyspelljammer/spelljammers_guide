#!/usr/bin/env bash

SHIPS=( Angelship
Antlership
Argosy
Armada
Barge_of_Ptah
Batship,_The
Battle_Cry
Battlewagon
Blade
Bloatfly
Caravel
Cargo_Barge
Citadel
Clipper
Coaster
Cog
Conflagrator
Crystal_Ship
Cuttle_Command
Damselfly
Deathglory
Deathspider
Decapitator
Defenestrator
Devastator
Dolphin
Doombat
Dragon_Claw
Dragonfly
Dragonship
Drakkar
Dreadnought
D_cont.
Dromond
Eel_Ship
Eviscerator
Far_Star
Flitter
Flying_Pyramid
Galleon
Great_Bombard
Great_Galley
Hammership
Hummingbird
Hunter-Killer
Klicklikak
Lamprey_Ship
Lanceship
Leaf_Ship
Libraria
Locust
Longship
Lucky_Victory
Mammoth
Man-O-War
Mantis
Mindspider
Monarch_Armada
Mosquito
Mutilator
Nautiloid
Nightwolf
Octopus
Porcupine_Ship
Quad_of_Thay
Scorpion
Shrikeship
Sidewheeler
Skeleton_Ship
Skiff
Smalljammer
Space_Leviathan
Spacesea_Giant_Galleon
Spelljammer,_The
Squid_Ship
Stoneship
Swan_Ship
Thoric_Tradesman
Thorn_Ship
Tradesman
Triop
Tsunami
Turtle_Ship
Tyrant_Ship
Ultimate_Victory
Unity_Ship
Urchin
Uspo
Vagabond
Vipership
Wasp
Werewolf
Whaleship
Whelk
Wreckboat )

convert(){
pup '.toccolours' | sed 's/<p>/\\n/g;s/<\/p>//g;s/<br>/\\n/g' | html2text -nobs -width 2500 |  echo -e "$(cat -)" | sed 's/[[:space:]][[:space:]]*/ /g' | sed 's/Built By /built_by: /g;s/Used Primarily By /used_primarily_by: /g;s/Cost /cost: /g;s/Tonnage /tonnage: /g;s/Hull Points /hull_points/g;s/Crew (Min\/Max) /crew: /g;s/Man-Days of Fresh Air /man_days_fresh_air: /g;s/Maneuver Class /maneuver_class: /g;s/Landing - Land /landing_land: /g;s/Landing - Water /landing_water: /g;s/Armour Rating /armor_rating: /g;s/Saves As /saves_as: /g;s/Power Type /power_type: /g;' | tr -d "'" |  sed 's/Ships Rating /ships_rating: /g;s/Standard Armament /standard_armament:\\n /g;s/Cargo /cargo: /g;s/Keel Length /keel_length: /g;s/Beam Length /beam_length: /g;s/Source /source: /g' | echo -e "$(cat -)" | tr "[:upper:]" "[:lower:]" | sed '1 s/^/name: /g' | sed 's/^ /  /g;s/ ,/,/g'
}

text(){
#pup '#mw-content-text > :not(table)' | html2text -nobs -width 100000 | sed 's/\[.*\]//g' | sed 's/^[[:space:]]*\**[[:space:]]*//g;s/[[:space:]]*\**$/:/g;s/[[:space:]]*[[:space:]]_Edit//g' | grep -v "^:$"
pup '#mw-content-text > :not(table)' |html2text -nobs -width 10000| sed 's/\[.*\]//g' | sed 's/^[[:space:]]*\**[[:space:]]*//g;s/[[:space:]][[:space:]]*\**$/:/g;s/[[:space:]]*[[:space:]]_Edit//g' | grep -v "^:$" | grep -v "^Contents:\|nocookie.net\|^References:$\|^[[:space:]]*$"
}
for ship in ${SHIPS[@]};do
  output="$(curl -qs "http://spelljammer.wikia.com/wiki/${ship}")"
  echo "${ship}:" | tr "[:upper:]" "[:lower:]"
  echo "${output}" | convert | sed 's/^/  /g'
  echo "  text:"
  echo "${output}" | text | sed 's/^/    /g'
  echo ""
done
