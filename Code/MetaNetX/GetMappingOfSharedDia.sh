#/bin/bash
rm DiaNamesMapping_of_shared
sort Mapped_in_Dia | uniq > Mapped_in_Dia_uniq
cut -d'|' -f 1 shared_MNXM_dia_tac | while read pat; do grep -w "$pat" Mapped_in_Dia_uniq >> DiaNamesMapping_of_shared ; if [[ `grep -cw "$pat" shared_MNXM_dia_tac` > 1 ]]; then echo $pat; fi; done
awk '{print $1}' DiaNamesMapping_of_shared > DiaNamesMapping_of_shared.NewMetNames
awk '{print $2}' DiaNamesMapping_of_shared > DiaNamesMapping_of_shared.OldMetNames

