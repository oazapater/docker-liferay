FROM debian:wheezy

MAINTAINER Oscar Zapater <oscar.zapater@gmail.com>

# install java
RUN apt-get update \
	&& apt-get install -y curl tar unzip \
	&& (curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz | tar xfz - -C /opt) \
	&& mv /opt/jdk1.7.0_79/jre /opt/jre1.7.0_79 \
	&& mv /opt/jdk1.7.0_79/lib/tools.jar /opt/jre1.7.0_79/lib/ext \
	&& rm -Rf /opt/jdk1.7.0_79 \
	&& ln -s /opt/jre1.7.0_79 /opt/java

# install liferay
RUN curl -O -s -k -L -C - http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.2.5%20GA6/liferay-portal-tomcat-6.2-ce-ga6-20160112152609836.zip \
	&& unzip liferay-portal-tomcat-6.2-ce-ga6-20160112152609836.zip -d /opt \
	&& rm liferay-portal-tomcat-6.2-ce-ga6-20160112152609836.zip

# add config for bdd
RUN /bin/echo -e '\nCATALINA_OPTS="$CATALINA_OPTS -Dexternal-properties="' >> /opt/liferay-portal-6.2-ce-ga6/tomcat-7.0.62/bin/setenv.sh

# add configuration liferay file
#ADD properties/portal-ext.properties /opt/liferay-portal-6.2-ce-ga6/portal-ext.properties
ADD properties/portal-bundle.properties /opt/liferay-portal-6.2-ce-ga6/portal-bundle.properties

# volumes
VOLUME ["/var/liferay-home", "/opt/liferay-portal-6.2-ce-ga6/"]

# Ports
EXPOSE 8080

# Set JAVA_HOME
ENV JAVA_HOME /opt/java

# EXEC
CMD ["run"]
ENTRYPOINT ["/opt/liferay-portal-6.2-ce-ga6/tomcat-7.0.62/bin/catalina.sh"]