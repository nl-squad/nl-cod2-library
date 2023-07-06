# cod2-library 🏞️

Library repo for maps used in CoD2 by NoLimits servers.

# CI / CD ⚡️

On **main** branch push all files will be tested if they don't contain any forbidden functions. Then if it succeeds all files will be deployed to VM under ~/cod2/library directory. Later on - when any server is restarted it needs to copy scripts and iwds and also build its own `000empty.iwd` file for purpose of generating pure client and refrence all the maps available.

# Roadmap 🛣️

✅ Support for iwds path nl-cli
✅ ./src/scripts -> ~/cod2/library/scripts
✅ ./src/iwds -> ~/cod2/library/iwds
✅ Get sha256sum of ~/cod2/library/iwds
✅ Compare with ~/cod2/library/iwds_sum
✅ If not the same - build ~/cod2/library/000empty.iwd
✅ ./restart.sh - copy ~/cod2/library/scripts
✅ ./restart.sh - copy ~/cod2/library/iwds
✅ ./restart.sh - copy ~/cod2/library/000empty.iwd
✅ ./restart.sh - restart docker-compose
