FROM c7_sysd_base

USER root

RUN yum -y install virt-install && yum install -y openssh && yum -y install wget && yum -y install unzip && yum -y install gcc && yum -y install python-devel && yum -y install net-tools && yum -y install less && yum -y install libvirt && yum -y install qemu-kvm && yum -y install libvirt-devel && yum -y install mkisofs

WORKDIR /jobs
ADD . /jobs

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install --upgrade pip && pip install --upgrade setuptools && pip install --upgrade -r requirements.txt

#condor installation
RUN cd /etc/yum.repos.d && wget http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo && wget http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && rpm --import RPM-GPG-KEY-HTCondor
RUN yum -y install condor
RUN cp condor_config.local /etc/condor/ && systemctl enable condor.service

#install cloudscheduler
RUN wget https://github.com/hep-gc/cloud-scheduler/archive/dev.zip && unzip dev.zip && cd cloud-scheduler-dev && python setup.py install
RUN cp /jobs/cloud-scheduler-dev/scripts/cloud_scheduler.init.d /etc/init.d/cloud_scheduler && cp /jobs/cloud-scheduler-dev/scripts/cloud_scheduler.sysconf /etc/sysconfig/cloud_scheduler && mkdir /etc/cloudscheduler && cp /jobs/cloud-scheduler-dev/cloud_resources.conf /etc/cloudscheduler && cp /jobs/cloud_scheduler.conf /etc/cloudscheduler && cp /jobs/cloud-scheduler-dev/default.yaml /etc/cloudscheduler
RUN cd /srv && mkdir userdata && cp /jobs/benchmark.yaml /srv/userdata/ && cp /jobs/verifycs.yaml /srv/userdata/

RUN systemctl enable libvirtd

#configure ssh keys
RUN ssh-keygen -q -f /root/.ssh/id_rsa -N "" && python generate-keyfile.py && cp auth-key.yaml /etc/cloudscheduler/auth-key.yaml 

#make the directories for images
RUN mkdir -p /jobs/instances/base
