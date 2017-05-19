# Zeppelin helper scripts

A series of scripts to set up and run a Zeppelin emr cluster

## Usage

1. Authenticate to IS-QA

2. Have the `is-qa-ap-southeast-2.pem` file in your `~/.ssh/` folder

3. Execute

```
$ start_zeppelin.sh
```

to create a Zeppelin EMR cluster and copy over the last 90 days of reports to S3 to use

4. Execute

```
connect_zeppelin.sh
```

to setup the socks proxy for accessing the web interface for zeppelin

5. Configure your proxy settings as explained in https://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-connect-master-node-proxy.html

6. View the Cluster in aws console in your browser, and click the Zeppelin link

7. After finish your work on zeppelin, execute

```
$ terminate_zeppelin.sh
```

to shutdown EMR and save $$$

## To load third part library in Zeppelin

1. Find out what master node as explained in https://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/EMR_SetUp_SSH.html
2. Copy the jar file you need to EMR cluster master node use scp. For example `scp 1.jar hadoop@masternode.dns.com:.`
2. Go to zeppelin console in browser. Click up right conner `anonymous` user menu select `interpreter`, go to the bottom `spark` section then click `edit` button. Add your jar file full path to `dependencies` section. Default `hadoop` user home path on EMR master node is `/home/hadoop`
