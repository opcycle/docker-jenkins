FROM opcycle/openjdk:11

ENV JENKINS_USER="jenkins" \
    JENKINS_UID="8983" \
    JENKINS_GROUP="jenkins" \
    JENKINS_GID="8983" \
    JENKINS_DIST_URL="http://mirrors.jenkins.io/war-stable/latest/jenkins.war"

RUN groupadd -r --gid "$JENKINS_GID" "$JENKINS_GROUP"
RUN useradd -r --uid "$JENKINS_UID" --gid "$JENKINS_GID" "$JENKINS_USER"
RUN mkdir -p /opt/jenkins/data
RUN curl -L $JENKINS_DIST_URL --output /opt/jenkins/jenkins.war
COPY jenkins /opt/jenkins
RUN chmod +x /opt/jenkins/jenkins
RUN chown jenkins:jenkins -R /opt/jenkins

VOLUME /opt/jenkins/data
WORKDIR /opt/jenkins
USER $JENKINS_USER

ENTRYPOINT ["/opt/jenkins/jenkins"]