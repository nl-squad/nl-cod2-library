#!/bin/bash

temp_dir=./tmp-000empty
mkdir -p "${temp_dir}/soundaliases"
mkdir -p "${temp_dir}/maps/mp"

timestamp=$(date +"%Y_%m_%d_%H_%M_%S")
echo " - soundaliases/nl_empty.csv (timestamp=$timestamp)"
cat << EOF > "${temp_dir}/soundaliases/nl_empty.csv"
name,sequence,file,vol_min,vol_max,vol_mod,pitch_min,pitch_max,dist_min,dist_max,channel,type,probability,loop,masterslave,loadspec,subtitle,compression,secondaryaliasname,volumefalloffcurve,startdelay,speakermap,reverb,lfe percentage
,,,,,,,,,,,,,,,,,,,,,,,
,,,,,,,,,,,,,,,,,,,,,,,
nl_empty_${timestamp},,null.wav,1,1,,,,,,music,loaded,,nonlooping,,,,,,,,,,
EOF

for file in src/iwds/*.iwds; do
    filename=$(basename "$file" .iwd)
    echo " - maps/mp/${filename}.csv"
    touch "${temp_dir}/maps/mp/${filename}.csv"
done

rm ~/cod2/library/000empty.iwd
(cd $temp_dir && zip -q -r ~/cod2/library/000empty.iwd .)
chmod 744 ~/cod2/library/000empty.iwd # make this readable for reverse-proxy
rm -r "${temp_dir}"