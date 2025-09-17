#!/bin/bash
scp -o StrictHostKeyChecking=no simple-webapp.war ec2-user@3.111.164.150:/home/ec2-user/
ssh ec2-user@3.111.164.150 "sudo mv /home/ec2-user/simple-webapp.war /usr/local/tomcat/webapps/simple-webapp.war && systemctl restart tomcat"

