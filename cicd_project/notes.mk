        # create VM with good configuration
project-server 

        # 1.  Jenkins Installation on Ubuntu ###
sudo su - ubuntu
sudo apt-get update
sudo apt-get install fontconfig openjdk-11-jre
#Install Jenkins with weekly release of below page
Refer---https://www.jenkins.io/doc/book/installing/linux/
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl enable jenkins       //Enable the Jenkins service to start at boot
sudo systemctl start jenkins        //Start Jenkins as a service
systemctl status jenkins

jenkins => setup => random agent, enable proxy server

        # 2. Ansible Installation on Ubuntu #
sudo su - ubuntu
$ sudo usermod -aG sudo ubuntu
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible-core
$ ansible --version

        # 3. integrate ansible with Jenkins #

ssh-keygen
cat /home/ubuntu/.ssh/id_rsa.pub ==> copy key
cd /home/ubuntu/.ssh/
ls 
nano authorized_keys  ==> paste key here
cd
ssh project-server

        ## 4. Docker Installation on ubuntu ##
$ cd /opt
$ sudo mkdir docker
$ ll
$ sudo chown ubuntu:ubuntu docker
$ ll
$ cd docker
$ sudo apt install docker.io
$ systemctl status docker
$ sudo usermod -aG docker ubuntu
$ id ubuntu

        ## 5. add a node ##
add node : ansible
    path => /opt/docker
    run the command in shell
    => connected

        ## 6. Create Ansible Playbook to Create Docker Image and Copy Image to DockerHub ##

add hosts in ansible : sudo nano /etc/ansible/hosts
   => copy and paste the internal ip 

ssh-copy-id 10.154.0.26 (verify)
cd /opt/docker/
nano cafe-app.yml
ls
sudo docker login ==> enter login details 
ansible-playbook cafe-app.yml --check
ansible-playbook cafe-app.yml
- check folder created ?
- check => docker images
- check in docker hub

##### CREATE CI JOB:

go to jenkins => new item => ci_job_cafeapp ==> freestyle project
git => https://github.com/saidhuljohny2/Cafe-App.git
branch => main
Restrict where this project can be run => ansible
Build Steps => execute shell => ansible-playbook /opt/docker/cafe-app.yml
build now => check console output

          # 7.  create GKE cluster in GCP #
go to kubernates => create a single node cluster

and then

# Install the gcloud CLI and kubectl, plugin
on root 
- google cli : https://cloud.google.com/sdk/docs/install#deb
- kubectl & plugin : https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#apt_1

=> Connect to the cluster from command
=> kubectl get nodes

          # 8. create deployement and service files
cd (root directory)
Refer--https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
nano cafe-app-deployment.yml
Refer---https://kubernetes.io/docs/tutorials/services/connect-applications-service/
nano cafe-app-service.yml

          # 9. Integrate Kube-Server with Ansible and Create Ansible Playbook for Deployment & Service Manifest files
add hosts in ansible : sudo nano /etc/ansible/hosts
at root user :
nano /etc/ssh/sshd_config
PasswordAuthentication yes
PermitRootLogin yes
systemctl restart sshd
passwd root
at ubuntu :
$ ssh-copy-id root@
$ ssh 'root@10.0.0.6'
 
$ nano kubernetes-deploy.yml
$ ansible-playbook kubernetes-deploy.yml
  => check in kube server for => kubectl get all => get the external ip to see website running 

           #10. create cd job for kubernates
go to new item => cd_job_cafeapp => freestyle => build steps => execute shell =>  ansible-playbook /opt/docker/kubernetes-deploy.yml

go to ci-job => 
  - change name of build yaml => create-image-cafe-app.yml 
  - add post build action 
      => build other projects => add cd-job project
  - poll scm => * * * * * (every minute)


          #11. testing phase 
      do some changes in source code and push => refresh the website ==> success





