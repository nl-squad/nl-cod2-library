# 🏞️ cod2-library

Library repo for maps used in CoD2 by NoLimits servers. It holds all the nl-squad custom-made maps and scripts.

# ⚡️ CI / CD

On **main** branch push all files will be tested if they don't contain any forbidden functions. Then if it succeeds all files will be deployed to VM under ~/cod2/library directory.

Later on - when any server is restarted it needs to copy scripts and iwds to its own contained library. Also a build of `000empty.iwd` file is required. This is for the purpose of generating a pure client and referencing all the maps available.

# 🛣️ Roadmap

✅ Support for iwds path nl-cli

✅ ./src/scripts -> ~/cod2/library/scripts

✅ ./src/iwds -> ~/cod2/library/iwds

✅ Get sha256sum of ~/cod2/library/iwds

✅ Compare with ~/cod2/library/iwds_sum

✅ If not the same - build ~/cod2/library/000empty.iwd

✅ Mapping ~/cod2/library/scripts on restart

✅ Mapping ~/cod2/library/iwds on restart

✅ Mapping ~/cod2/library/000empty.iwd on restart

✅ ./restart.sh - restart docker-compose

✅ CI/CD integration
