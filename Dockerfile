# We will use Ubuntu for our image
FROM ubuntu:bionic

# Updating Ubuntu packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libblas3 libgmp10 libgsl2 liblapack3 && apt-get clean


# Add user ubuntu with no password
# The --gecos parameter is used to set the additional information. In this case it is just empty.
RUN adduser --disabled-password --gecos '' ubuntu
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/
#RUN echo `pwd`
COPY SCIPOptSuite-6.0.1-Linux.deb /home/ubuntu/
COPY markshare2.mps /home/ubuntu/
RUN dpkg -i /home/ubuntu/SCIPOptSuite-6.0.1-Linux.deb