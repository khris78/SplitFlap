#!/bin/bash

letters="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "

for (( pos=0 ; pos<${#letters} ; pos++ ))
do
  top_letter=${letters:pos:1}
  if (( pos + 1 != ${#letters} ))
  then
    bottom_letter=${letters:pos+1:1}
  else
    bottom_letter=${letters:0:1}
  fi

  echo "$pos : $top_letter => $bottom_letter"
  
  openscad -o "Card_$top_letter.stl" Card.scad -D "letter_top=\"$top_letter\"" -D "letter_bottom=\"$bottom_letter\""

  openscad -o "Letter_$top_letter.stl" Letter.scad -D "letter_top=\"$top_letter\"" 
done
