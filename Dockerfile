FROM maven:3.8.6-amazoncorretto-11 as build

# Work around a bug in Java 1.8u181 / the Maven Surefire plugin.
# See https://stackoverflow.com/questions/53010200 and
# https://issues.apache.org/jira/browse/SUREFIRE-1588.
ENV JAVA_TOOL_OPTIONS "-Djdk.net.URLClassPath.disableClassPathURLCheck=true"

# Build Sakai.
COPY sakai sakai
WORKDIR sakai

# nb. Skip tests to speed up the container build.
RUN mvn install -Dmaven.test.skip=true

# Download and install Apache Tomcat.
RUN mkdir -p /opt/tomcat
RUN curl "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz" > /opt/tomcat/tomcat.tar.gz
RUN tar -C /opt/tomcat -xf /opt/tomcat/tomcat.tar.gz --strip-components 1

# Configure Tomcat.
# See https://confluence.sakaiproject.org/display/BOOT/Install+Tomcat+8
ENV CATALINA_HOME /opt/tomcat
COPY context.xml /opt/tomcat/conf/
COPY setenv.sh /opt/tomcat/bin/
COPY server.xml /opt/tomcat/conf/

# Install web app.
RUN mvn sakai:deploy -Dmaven.tomcat.home=/opt/tomcat


WORKDIR sakai

FROM amazoncorretto:11

# Copy Sakai configuration.
COPY sakai.properties /opt/tomcat/sakai/

# Copy Sakai and Tomcat.
COPY --from=build /opt/tomcat /opt/tomcat

# Run Sakai
EXPOSE 8080
WORKDIR /opt/tomcat/bin
CMD ./startup.sh && tail -f ../logs/catalina.out
