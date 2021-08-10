FROM centos:7
RUN yum install -y iproute

CMD ["/bin/bash"]