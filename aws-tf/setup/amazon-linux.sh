#! /bin/bash
# 
# Script to run on Amazon-Linux. 
#
yum update -y

amazon-linux-extras install docker -y

yum install docker -y
service docker start
usermod -a -G docker ec2-user

history -c
