set -x
set -e

COMMAND=$0
USER_PARAM=$1

function usage {
    echo "usage: $COMMAND [rea username]"
    exit 1
}

if [ -z "$IDP_USER" ] && [ -z "$USER_PARAM" ]; then
  usage
  exit 1
elif [ ! -z "$IDP_USER" ]; then
  EMR_USER=$IDP_USER
elif [ ! -z "$USER_PARAM" ]; then
  EMR_USER=$USER_PARAM
fi

CLUSTER_NAME=consumer-insight-zeppelin-${EMR_USER}
CONTACT=${EMR_USER}@rea-group.com

INSTANCE_TYPE=r3.4xlarge
NODE_NUMBER=1
KEY=is-qa-ap-southeast-2

aws emr create-cluster --name ${CLUSTER_NAME} --no-auto-terminate --release-label emr-5.4.0 --applications Name=Spark Name=GANGLIA Name=Zeppelin \
--ec2-attributes KeyName=$KEY,InstanceProfile=EMR_EC2_DefaultRole  --instance-type ${INSTANCE_TYPE} --instance-count ${NODE_NUMBER} \
--tags application="zeppelin-${IDP_USER}" contact=$CONTACT --service-role EMR_DefaultRole --configurations file://./myConfig.json > id.txt

exit 0
