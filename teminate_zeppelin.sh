set -x
set -e

id=`jq .ClusterId id.txt | tr -d '"'`

aws emr terminate-clusters --cluster-ids $id
