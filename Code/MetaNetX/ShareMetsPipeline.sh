
#/bin/bash
#  a bash pipeline to get shared compounds between sino boundary mets and truncatula cellular (cytosolic mets)
# initial compounds lists are in Sino_boundary.mets and Truncatula_Cytosol.mets
# MNX reference file is chem_xref.tsv
# final output file is in Mapped_in_shared

echo
echo "*** Starting bash pipeline for getting shared mets between sino and truncatula ***"
echo

#cp ../tac_boundary.mets .

# Replace MNX mapping system by searching in the MNX source file (chem_xref.tsv) directly

perl SearchInMNX_tac.pl tac_all.mets
perl SearchInMNX_dia.pl Dia_all.mets

# Get MNX notation for boundary tac mets and cellular dia mets
echo ">Get MNX notation for boundary sino mets and cellular truncatula mets"
./GetMappedMets_tac.sh
./GetMappedMets_dia.sh
echo done
echo

echo ">Identify shared mets between the two"
# Identify shared mets between the two
./GetShared_MNX.sh
echo done
echo

echo ">Get functional annotation of the shared mets"
# Get functional annotation of the shared boundary mets
./GetMappedMets_shared.sh
echo done
echo


echo ">Get tac unshared mets"
# Get tac boundary mets that are not shared with the plant
#./GetUnsharedSino.sh
echo done
echo

echo ">Get tac met names of shared mets"
# Get the  tac names for the metabolites that are shared with the plant
./GetMappingOfSharedTac.sh
echo done
echo

echo ">Get dia met names of shared mets"
# do the same for the dia model
./GetMappingOfSharedDia.sh
echo done
echo

echo ">Prepare new namings for importing in matlab -tac model"
# create two arrays with new and old names for use in Matlab
perl PrepareMetsSubstituion_Tac.pl TacNamesMapping_of_shared
echo done
echo

echo ">Prepare new namings for importing in Matlab -truncatula model"
# create two arrays with new and old names for use in Matlab 
perl PrepareMetsSubstituion_Dia.pl DiaNamesMapping_of_shared
echo
echo
echo "*** Done, end of bash pipeline, going back to matlab code ***"
echo 
echo
