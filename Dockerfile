FROM centos:7

# switch to the root user
USER root

# create a /deployment folder to run uber jars
# install java 8
# clean the yum cache
# create the user 'app' with uid=1001 to run the uber jar (a folder is also created for the user)
RUN mkdir -p /deployments && \
    yum install -y bash java-1.8.0-openjdk && \
    yum clean all -y && rm -rf /var/cache/yum && \
    useradd -d /app -m -u 1001 app

# set image labels
LABEL io.k8s.description="S2I image to build applications which use Java 8." \
      io.k8s.display-name="Java 8 S2I Builder" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
      io.openshift.s2i.destination=/tmp

# copy s2i scripts
COPY ./.s2i/bin/ /usr/local/s2i

# copy hawkular and jolokia configuration
COPY ./opt/ /opt/

# configure ownership and permissions
RUN mkdir -p /opt/jolokia/etc && chmod -R a+w /opt/jolokia/etc && \
    chmod -R a+rx /usr/local/s2i && chmod -R a+rx /opt && chmod a+rx /opt/run-java/run-java.sh && \
    chown -R 1001:1001 /deployments/ && \
    chmod a+rwx -R /app && chown -R 1001:1001 /app

# switch to the app user
USER app

# set the working directory
WORKDIR /deployments/

# set environment variables
ENV JAVA_APP_DIR=/deployments \
    JAVA_HOME=/etc/alternatives/jre

# expose ports for the application and monitoring agents
EXPOSE 8080 8443 8778 9779

CMD [ "run" ]
