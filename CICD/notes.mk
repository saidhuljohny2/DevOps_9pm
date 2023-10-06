        # 1.  Jenkins Installation on Ubuntu ###

$ sudo apt update
$ sudo apt install default-jdk
$ update-alternatives --config java    //To find out where apt installed Java on Ubuntu
$ sudo nano /etc/environment
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
JAVA_HOME="/lib/jvm/java-11-openjdk-amd64/bin/java"
$ source /etc/environment 
$ echo $JAVA_HOME
#Install Jenkins with weekly release of below page
Refer---https://www.jenkins.io/doc/book/installing/linux/
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
$ sudo systemctl enable jenkins       //Enable the Jenkins service to start at boot
$ sudo systemctl start jenkins        //Start Jenkins as a service
$ systemctl status jenkins

        # 2. Ansible Installation on Ubuntu ###

Refer--https://phoenixnap.com/kb/install-ansible-ubuntu-20-04
$ sudo adduser ansibleadmin
$ sudo usermod -aG sudo ansibleadmin
$ sudo init 6
$ sudo su ansibleadmin
$ ssh-keygen       //public key is at /home/ansibleadmin/.ssh/id_rsa.pub
$ cd /home/ansibleadmin
$ cd .ssh
$ ls
$ cd ~
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible-core
$ ansible --version

        # 3. integrate ansible with Jenkins and install Docker on ansible-server

# need to install plugin :  
  - go to jenkins dashboard => manage jenkins 
  - plugins => available plugins => Publish Over SSH => install 

# ingtegration :
  - go to jenkins dashboard => manage jenkins => system 
  - go down => Publish Over ssh => add SSH Servers => 




$ cd /opt
$ sudo mkdir docker
$ sudo chown ansibleadmin:ansibleadmin docker
$ sudo apt install docker.io
$ systemctl status docker
$ sudo usermod -aG docker ansibleadmin
$ id ansibleadmin