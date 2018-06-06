# Astuces
1. Configurer RUN/DEBUG tomcat avec une configuration (.jar) externe dans IntelliJ IDEA:
* -Xbootclasspath/a:URL_TO_CONF\FILE.jar
 
2. Proxifier un appel sortant de la VM
* -Dhttp.proxyHost=localhost -Dhttp.proxyPort=8989 -Dhttp.nonProxyHosts="localhost" -Djavax.net.debug=all
3. Docker RHEL7 repo
* docker pull registry.access.redhat.com/rhel7
