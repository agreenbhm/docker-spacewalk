FROM centos:centos6

ADD ./jpackage.repo /etc/yum.repos.d/jpackage.repo
ADD ./answers.properties /etc/spacewalk/answers.properties

RUN yum update -y && yum clean all
RUN yum install --setopt=tsflags=nodocs -y http://yum.spacewalkproject.org/2.3/RHEL/6/x86_64/spacewalk-repo-2.3-4.el6.noarch.rpm && yum clean all
RUN yum install --setopt=tsflags=nodocs -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && yum clean all
RUN yum install --setopt=tsflags=nodocs -y spacewalk-setup-postgresql spacewalk-postgresql supervisor && yum clean all
RUN spacewalk-setup --disconnected --answer-file=/etc/spacewalk/answers.properties -skip-db-diskspace-check

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./run-spacewalk.sh /usr/local/bin/run-spacewalk.sh

EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/run-spacewalk.sh"]

