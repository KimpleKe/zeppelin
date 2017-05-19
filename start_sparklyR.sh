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

#CLUSTER_NAME=consumer-insight-zeppelin-${EMR_USER}
CLUSTER_NAME=bca-zeppelin-rstudio-${EMR_USER}

CONTACT=${EMR_USER}@rea-group.com

INSTANCE_TYPE=r3.4xlarge
NODE_NUMBER=1
KEY=is-qa-ap-southeast-2

##
## modified based loosely on https://aws.amazon.com/blogs/big-data/running-sparklyr-rstudios-r-interface-to-spark-on-amazon-emr/
##
## changed to emr-5.3.0 from emr-5.2.0 on 6 Feb

aws emr create-cluster --name ${CLUSTER_NAME} --no-auto-terminate --release-label emr-5.3.0 --applications Name=Spark Name=GANGLIA Name=Zeppelin \
--ec2-attributes KeyName=$KEY,InstanceProfile=EMR_EC2_DefaultRole  --instance-type ${INSTANCE_TYPE} --instance-count ${NODE_NUMBER} \
--tags application="zeppelin-${IDP_USER}" contact=$CONTACT --service-role EMR_DefaultRole --configurations file://./myConfig.json \
--bootstrap-actions Path=s3://aws-bigdata-blog/artifacts/aws-blog-emr-rstudio-sparklyr/rstudio_sparklyr_emr5.sh,\
Args=["--rstudio","--sparkr","--rexamples","--plyrmr","--rhdfs","--sparklyr","--latestR"],\
Name="Install RStudio" --configurations '[{"Classification":"spark","Properties":{"maximizeResourceAllocation":"true"}}]'  > id.txt

exit 0
