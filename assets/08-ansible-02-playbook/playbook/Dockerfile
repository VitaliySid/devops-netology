# systemd is included with centos:7 but not enabled by default - START
# https://hub.docker.com/_/centos:
FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
# install yum dependencies ansible
RUN yum install -y epel-release \
  && yum install -y nginx && systemctl enable nginx.service

EXPOSE 80

CMD ["/usr/sbin/init"]
# systemd is included with centos:7 but not enabled by default - END
# docker build --rm -t local/centos7-systemd -f centos7-systemd.Dockerfile .