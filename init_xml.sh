value
#!/bin/sh
# Setup data lake SPN for Databricks cluster.
# Enable hiding of sensitve properties through "SET" statements as well as on the SparkUI

# databricks --profile prdplfdatabricks01 fs cp init_devaoldbs02.sh dbfs:/databricks/init/devaoldbs02/init_devaoldbs02.sh --overwrite

cat <<EOT > /databricks/driver/conf/00-custom-spark.conf
[driver] {
    # ADLS connection information
    "spark.hadoop.dfs.adls.oauth2.access.token.provider.type" = "ClientCredential"
    "spark.hadoop.dfs.adls.oauth2.client.id" = "*************"
    "spark.hadoop.dfs.adls.oauth2.credential" = "************"
    "spark.hadoop.dfs.adls.oauth2.refresh.url" = "https://login.microsoftonline.com/**********/oauth2/token"

    "spark.hadoop.fs.azure.account.auth.type.prdpersoadl.dfs.core.windows.net" = "OAuth"
    "spark.hadoop.fs.azure.account.oauth.provider.type.prdpersoadl.dfs.core.windows.net" = "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
    "spark.hadoop.fs.azure.account.oauth2.client.id.prdpersoadl.dfs.core.windows.net" = "*************"
    "spark.hadoop.fs.azure.account.oauth2.client.secret.prdpersoadl.dfs.core.windows.net" = "****************"
    "spark.hadoop.fs.azure.account.oauth2.client.endpoint.prdpersoadl.dfs.core.windows.net" = "https://login.microsoftonline.com/**********/oauth2/token"

    # Hide sensitive config values
    "spark.hadoop.hive.conf.hidden.list" = "spark.hadoop.javax.jdo.option.ConnectionPassword,hive.server2.keystore.password,spark.hadoop.dfs.adls.oauth2.credential,spark.hadoop.dfs.adl.oauth2.credential"
    "spark.redaction.regex" = "(?i)secret|password|oauth2"
}
EOT
