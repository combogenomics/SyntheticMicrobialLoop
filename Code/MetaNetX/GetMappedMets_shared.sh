
#/bin/bash
rm Mapped_in_shared
cut -d'|' -f 1 shared_MNXM_dia_tac | while read pat; do grep -w "$pat" chem_prop.tsv >> Mapped_in_shared; if [[ `grep -cw "$pat" shared_MNXM_dia_tac` > 1 ]]; then echo $pat; fi; done
