# Stop any running Jenkins processes
pkill -f jenkins.war

# Move to your DevOps lab directory
cd /home/ec2-user/Devops-lab

# Clean old war folder inside jenkins_home if it exists
rm -rf jenkins_home/war

# Ensure jenkins_home exists and has proper permissions
mkdir -p jenkins_home
chown -R ec2-user:ec2-user jenkins_home

# Download the latest Jenkins WAR if not already present
if [ ! -f jenkins.war ]; then
    wget https://get.jenkins.io/war-stable/2.516.1/jenkins.war
fi

# Start Jenkins with nohup in the background
nohup java -DJENKINS_HOME=/home/ec2-user/Devops-lab/jenkins_home -jar jenkins.war --httpPort=8080 > jenkins.log 2>&1 &
echo "Jenkins is starting... Check logs with: tail -f jenkins.log"

