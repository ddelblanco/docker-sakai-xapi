export JAVA_OPTS="-server -Xms1g -Xmx2g -Djava.awt.headless=true -XX:+UseCompressedOops -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC"
JAVA_OPTS="$JAVA_OPTS -Dhttp.agent=Sakai"
JAVA_OPTS="$JAVA_OPTS -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false"
JAVA_OPTS="$JAVA_OPTS -Dsakai.security=$CATALINA_HOME/sakai/"
JAVA_OPTS="$JAVA_OPTS -Duser.timezone=US/Eastern"
JAVA_OPTS="$JAVA_OPTS -Dsakai.cookieName=SAKAI2SESSIONID"
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8089 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
