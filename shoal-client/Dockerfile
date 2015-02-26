# shoal-client
#
# VERSION 0.0.1
FROM centos:6
MAINTAINER Ian Gable <igable@uvic.ca>

RUN yum update -y \
    && yum clean all \
    && yum install epel-release -y \
    && yum clean all \
    && curl http://shoal.heprc.uvic.ca/repo/shoaldev.repo -o /etc/yum.repos.d/shoal.repo \
    && yum update -y \
    && yum install shoal-client -y \
    && yum clean all
