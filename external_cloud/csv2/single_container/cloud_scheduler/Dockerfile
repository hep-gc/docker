# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>
#
#
# Adapted by Danika MacDonell for containerized setup of cloudscheduler version 2 (csv2)
# <danikam1@uvic.ca>
#

FROM centos:centos7

USER root

# Install useful packages
RUN yum -y install emacs && yum install -y iproute && yum -y install telnet

# Install packages needed for ssh
RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd; yum clean all
RUN mkdir /var/run/sshd

# Generate public rsa key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

# Give root password secret
RUN echo 'root:secret' | chpasswd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

WORKDIR /jobs
ADD . /jobs

# Create an authorized_keys file
RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys

# Add the host computer's public rsa key to the authorized_keys file (the public rsa key must already exist)
ADD /root/.ssh/id_rsa.pub /jobs
RUN cat id_rsa.pub >> /root/.ssh/authorized_keys

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
