
#/bin/bash

rm  Mapped_in_Dia
sed 's/_e//' dia_boundary.mets > dia_boundary.mets_no_compartment
cut -d'|' -f 1 dia_boundary.mets_no_compartment | while read pat; do grep -w "$pat"  MappedCompoundsDia >> Mapped_in_Dia; if [[ `grep -wc "$pat" MappedCompoundsDia` > 1 ]]; then echo $pat; fi; done
