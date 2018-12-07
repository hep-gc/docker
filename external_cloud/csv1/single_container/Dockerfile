FROM centos:7

USER root

RUN yum -y install virt-install && yum install -y openssh && yum -y install wget && yum -y install unzip && yum -y install gcc && yum -y install python-devel && yum -y install net-tools && yum -y install less && yum -y install libvirt && yum -y install qemu-kvm && yum -y install libvirt-devel && yum -y install mkisofs && yum -y install emacs && yum -y install sudo && yum -y install mlocate && yum -y install git

WORKDIR /jobs
ADD . /jobs

ADD systemctl.py /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install --upgrade pip && pip install --upgrade setuptools && pip install --upgrade -vvv --ignore-installed -r requirements.txt

# Install packages needed for ssh
RUN yum -y update; yum clean all
RUN yum -y --setopt=tsflags=nodocs install openssh-server

# Install supervisor
RUN easy_install supervisor

# Backup original sshd_config
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
RUN chmod a-w /etc/ssh/sshd_config.orig
# Make directories to store services' data
RUN mkdir /var/run/sshd /var/log/supervisor

# Generate public rsa key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

# Set root password
RUN echo 'root:supersecret' | chpasswd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Add supervisor's configuration file to the container. Note: This config file is referred by supervisord once started inside container
COPY supervisord.conf /usr/etc/supervisord.conf

# Expose needed ports
EXPOSE 947 9618
EXPOSE 40000-40500

# Create an authorized_keys file
RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJ13KaaMGJ1ifkQpDAuB3CCHEO6wn8XIKJgm5EYBGxEF5uPiyTQlb1/AtwBmruQkPuYJNcfnlG5wk1LTeDBW2Znp5qb3GTnN0zWnj7PmzOKIbH8Wo/sQB3ufW/hA1VorDMXEXM7rCefPhVu/YUoNAnafx4DMX9sszm/BS9O5Z+LprVyJfEaAKH9ZwP15RuzLCB1K4MdbYMULSTcYbdIQ0vBujZz53oRQOEDHfBBrqdiC4MqUfaa6q8OitmglhP5YjYjio1A68kyRwXDuekKhKvP+yqezZZh2PPoKP2q6rHxvfQl2NDJhCmuO4z82iWVTL/RcbGkZEJZhmg1c+oulT1 danikamacdonell@Danikas-MacBook-Pro.local" >> /root/.ssh/authorized_keys

#condor installation
RUN cd /etc/yum.repos.d && wget http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo && wget http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && rpm --import RPM-GPG-KEY-HTCondor
RUN yum -y install condor
RUN cp condor_config.local /etc/condor/

#install cloudscheduler
RUN wget https://github.com/hep-gc/cloud-scheduler/archive/dev.zip && unzip dev.zip && rm dev.zip
RUN cd cloud-scheduler-dev && python setup.py install

RUN cp /jobs/cloud-scheduler-dev/scripts/cloud_scheduler.init.d /etc/init.d/cloud_scheduler && cp /jobs/cloud-scheduler-dev/scripts/cloud_scheduler.sysconf /etc/sysconfig/cloud_scheduler && mkdir /etc/cloudscheduler && cp /jobs/cloud_resources.conf /etc/cloudscheduler && cp /jobs/cloud_scheduler.conf /etc/cloudscheduler && cp /jobs/default.yaml /etc/cloudscheduler && cp /jobs/cloud-scheduler-dev/cloudscheduler/defaults.cfg /etc/cloudscheduler

RUN cd /srv && mkdir userdata && cp /jobs/benchmark.yaml /srv/userdata/ && cp /jobs/verifycs.yaml /srv/userdata/

#configure ssh keys
RUN ssh-keygen -q -f /root/.ssh/id_rsa -N "" && python generate-keyfile.py && cp auth-key.yaml /etc/cloudscheduler/auth-key.yaml 

#make the directories for local images
RUN mkdir -p /jobs/instances/base 

# make the condor user accessible
RUN chsh -s /bin/bash condor

# create a log directory for the condor user
RUN mkdir /var/lib/condor/logs && chown condor /var/lib/condor && chown condor /var/lib/condor/logs

# Run the startup.sh script
#RUN chmod +x startup.sh
#CMD ./startup.sh

# Execute supervisord as entrypoint into the container
CMD ["/usr/bin/supervisord"]