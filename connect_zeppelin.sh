id=`jq .ClusterId id.txt | tr -d '"'`
DNS=`aws emr describe-cluster --cluster-id $id | jq .Cluster.MasterPublicDnsName | tr -d '"'`
if [ ! -z "$DNS" ]; then
  ZEPPELIN_URL="http://${DNS}:8890/"
  echo "Connect to zeppelin by ${ZEPPELIN_URL}"
fi
aws emr socks --cluster-id $id --key-pair-file ~/.ssh/is-qa-ap-southeast-2.pem
