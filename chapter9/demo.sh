# setup env variables for anchore-cli
export ANCHORE_CLI_USER="admin"
export ANCHORE_CLI_URL=${ANCHORE_CLI_URL}
export ANCHORE_CLI_PASS=${ANCHORE_CLI_PASS}
export ANCHORE_CLI_SSL_VERIFY=n

# run image scan
img="docker.io/kaizheh/apache-struts2-cve-2017-5638:latest"

# add image
anchore-cli image add $img

# get sha value
sha=$(anchore-cli --json --api-version=0.2.4 image get $img | jq .[0].imageDigest -r)

echo $sha

# wait 30 senconds for analysis
sleep 30

# evaluate policy
status=$(anchore-cli --json evaluate check $sha --tag $img | jq --arg sha "$sha" --arg img "$img" '.[0][$sha][$img][0]["status"]' -r)

echo $status

if [ "$status" != "pass" ]; then
    exit 1;
fi
