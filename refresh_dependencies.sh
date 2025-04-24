grn=$'\e[1;32m'
end=$'\e[0m'
SECONDS=0
find . -name "*.lock" -type f -delete
sh clean.sh
sh get.sh
duration=$SECONDS
echo "${grn}All done in $(($duration / 60)) minutes and $(($duration % 60)) seconds.${end}"