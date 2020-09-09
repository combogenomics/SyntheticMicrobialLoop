#/bin/bash
rm TacNamesMapping_of_shared
sort Mapped_in_Tac | uniq > Mapped_in_Tac_uniq
cut -d'|' -f 1 shared_MNXM_dia_tac | while read pat; do grep -w "$pat" Mapped_in_Tac_uniq >> TacNamesMapping_of_shared ; if [[ `grep -cw "$pat" shared_MNXM_dia_tac` > 1 ]]; then echo $pat; fi; done
awk '{print $1}' TacNamesMapping_of_shared > TacNamesMapping_of_shared.NewMetNames
awk '{print $2}' TacNamesMapping_of_shared > TacNamesMapping_of_shared.OldMetNames




