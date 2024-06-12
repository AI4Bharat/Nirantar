path=$1
op=${path%.*}
for l in $(cat $path | jq -r .lang | uniq)
do
cat $path | grep "\"lang\": \"${l}\"" > ${op}_${l}.json
done