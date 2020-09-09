
#/bin/bash

rm  Mapped_in_Tac
sed 's/\[e\]//' tac_boundary.mets > tac_boundary.mets_no_compartment
cut -d'|' -f 1 tac_boundary.mets_no_compartment | while read pat; do grep -w "$pat"  MappedCompoundsTac >> Mapped_in_Tac; if [[ `grep -wc "$pat" MappedCompoundsTac` > 1 ]]; then echo $pat; fi; done
