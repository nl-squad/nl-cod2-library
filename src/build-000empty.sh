#!/bin/bash
cwd="$(dirname "$(realpath "$0")")"
echo "Executing in $cwd"

new_sha=$(find $cwd/iwds -type f -exec sha256sum {} \; | sort -k 2 | sha256sum)
old_sha=""
if [ -f $cwd/iwds_sum ]; then
    old_sha=$(cat $cwd/iwds_sum)
fi

echo "new_sha=$new_sha"
echo "old_sha=$old_sha"

if [[ "$new_sha" == "$old_sha" ]]; then
    echo "It seems that the iwds didn't change, probably just scripts update"
    echo "Skipping 000empty.iwd build"
    exit 0
fi

echo "Detected change in iwd files, building new 000empty.iwd"

echo $new_sha > $cwd/iwds_sum
echo "Saved $(cat $cwd/iwds_sum) SHA to $cwd/iwds_sum"

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

for file in iwds/*.iwds; do
    filename=$(basename "$file" .iwd)
    echo " - maps/mp/${filename}.csv"
    touch "${temp_dir}/maps/mp/${filename}.csv"
done

rm -f $cwd/000empty.iwd
(cd $temp_dir && zip -q -r $cwd/000empty.iwd .)
chmod 744 $cwd/000empty.iwd # make this readable for reverse-proxy
rm -r "${temp_dir}"