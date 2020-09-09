#!/bin/bash

awk '{print $1}' Mapped_in_Tac > Tac_MNXM
awk '{print $1}' Mapped_in_Dia > Dia_MNXM

cat Tac_MNXM | sort > one_list.tmp
cat Dia_MNXM | sort > two_list.tmp

comm -12 <(sort one_list.tmp | uniq) <(sort two_list.tmp | uniq)  > shared_MNXM_dia_tac


rm *.tmp
