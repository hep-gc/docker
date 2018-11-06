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
# build: docker build -t csv2_cont .
# run: docker run -d --name csv2_cont_run -p 2222:22 -p 80:80 -p 443:443 csv2_cont

FROM centos:centos7

USER root

# Install useful packages
RUN yum -y install emacs && yum install -y iproute && yum -y install telnet && yum -y install cronie && yum -y install firewalld && yum -y install net-tools && yum -y install mlocate

# skip heprc yum mirror if unavailable
RUN yum-config-manager --save --setopt=heprc.skip_if_unavailable=true

# Install packages needed for ssh and httpd
RUN yum -y update; yum clean all
RUN yum -y --setopt=tsflags=nodocs install openssh-server httpd python-setuptools && yum clean all

# Install supervisor
RUN easy_install supervisor

# Backup original sshd_config
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
RUN chmod a-w /etc/ssh/sshd_config.orig
# Make directories to store services' data
RUN mkdir /var/run/sshd /var/log/supervisor

# Generate public rsa key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

# Give root password secret
RUN echo 'root:secret' | chpasswd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Add supervisor's configuration file to the container. Note: This config file is referred by supervisord once started inside container
COPY supervisord.conf /usr/etc/supervisord.conf

# Allow ports 22 and 80 for container
EXPOSE 22 80 443 3306

WORKDIR /jobs
ADD . /jobs

# Create systemctl command
ADD systemctl.py /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

# Create an authorized_keys file
RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys

# Add the host computer's public rsa key to the authorized_keys file (the public rsa key must already exist)
#ADD /root/.ssh/id_rsa.pub /jobs
RUN cat id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAy3lHvsJ7lqjYGNxNfzXCh5VbvYalRPH8SKbYF9+vvJYxc+061Gr+5LOgZ9eXt4MTQc7/Kl+TSwZgk6F2lMjFZGvkfTM5p/+jgRq2SDSRjZvb97h6mlyIEGfeTdpeOJwrWmlcxr9zYR1Vs6u7RxASYDCk+2BNoLk+UkL8TJ8LFLJvu7LIWnl9X4ZSrNz98mVqbtPBzkUoQmPKGngU58Cv3HqKi7Bn74cf4lEWmOKRT2k1YNQ2R5Jqm9x8PWWA4BCh7cdFrEcPhS38Y688vhG1KbhZSPecLE6ShMArTvsNeTKrUOcotzsi812JnV/lw0i7PMtkUmpjTze/fRj8gkGBlQ== root@elephant01.heprc.uvic.ca" >> /root/.ssh/authorized_keys 

# Execute supervisord as entrypoint into the container
CMD ["/usr/bin/supervisord"]


#ENTRYPOINT ["/usr/sbin/sshd", "-D"]
