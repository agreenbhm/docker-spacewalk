FROM centos:centos7

ADD ./jpackage.repo /etc/yum.repos.d/jpackage.repo
ADD ./answers.properties /etc/spacewalk/answers.properties

RUN yum install --setopt=tsflags=nodocs -y http://yum.spacewalkproject.org/2.4/RHEL/7/x86_64/spacewalk-repo-2.4-3.el7.noarch.rpm
RUN yum install --setopt=tsflags=nodocs -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install --setopt=tsflags=nodocs -y spacewalk-setup-postgresql spacewalk-postgresql supervisor
RUN spacewalk-setup --disconnected --answer-file=/etc/spacewalk/answers.properties

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./run-spacewalk.sh /usr/local/bin/run-spacewalk.sh

EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/run-spacewalk.sh"]

