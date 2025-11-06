project document for r CI/CD Pipeline using Jenkins + Maven + GitHub + Ansible + Tomcat.

This includes EVERY STEP from EC2 setup → Jenkins → Maven → GitHub → Ansible → Tomcat → CI/CD pipeline execution.
________________________________________
📘 END-TO-END CI/CD PROJECT DOCUMENTATION
Deploy Java Web App to Two Tomcat Servers Using Jenkins + Ansible
________________________________________
✅ 1. PROJECT OVERVIEW
This project demonstrates a complete CI/CD pipeline for deploying a Java web application (WAR) to two Apache Tomcat servers using:
✅ GitHub – Source code
✅ Jenkins – CI/CD automation
✅ Maven – Build & package WAR
✅ Ansible – Automated deployment
✅ Tomcat – Application hosting
✅ SCP & SSH – File transfer
________________________________________
✅ 2. PROJECT ARCHITECTURE
Developer → GitHub → Jenkins (Build WAR) → Ansible Server → Tomcat Servers
Flow:
1.	Developer pushes code to GitHub.
2.	Jenkins detects changes and builds the project using Maven.
3.	Jenkins copies sample.war to Ansible controller.
4.	Jenkins triggers Ansible Playbook via SSH.
5.	Ansible deploys WAR to two Tomcat servers.
6.	Tomcat hosts the updated web app.
________________________________________
✅ 3. SERVER SETUP
✅ Create 4 EC2 Instances:
Purpose	Instance Type	OS
Jenkins Server	t2.micro	Ubuntu
Ansible Control Node	t2.micro	Ubuntu
Tomcat Server 1	t2.micro	Ubuntu
Tomcat Server 2	t2.micro	Ubuntu
________________________________________
✅ 4. INSTALL TOMCAT ON BOTH TOMCAT SERVERS
Run the following on each Tomcat EC2:
Step 1 — Install Java
sudo apt update -y
sudo apt install openjdk-17-jdk -y
Step 2 — Download Tomcat
cd /opt
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.111/bin/apache-tomcat-9.0.111.tar.gz
sudo tar -xvzf apache-tomcat-9.0.111.tar.gz
sudo mv apache-tomcat-9.0.111 tomcat9
sudo chmod +x /opt/tomcat9/bin/*.sh
Start Tomcat
sudo /opt/tomcat9/bin/startup.sh
Access Tomcat:
http://<TOMCAT_IP>:8080
________________________________________
✅ 5. ANSIBLE CONTROL NODE SETUP
Install Ansible
sudo apt update -y
sudo apt install ansible -y
SSH Setup (IMPORTANT)
Copy Ansible server public key to both Tomcat servers:
ssh-copy-id ubuntu@<tomcat1-ip>
ssh-copy-id ubuntu@<tomcat2-ip>
________________________________________
✅ 6. CREATE ANSIBLE PROJECT STRUCTURE
On Ansible server:
mkdir tomcat-deploy
cd tomcat-deploy
inventory.ini
[tomcat]
tomcat1 ansible_host=<TOMCAT1_IP> ansible_user=ubuntu
tomcat2 ansible_host=<TOMCAT2_IP> ansible_user=ubuntu
deploy.yml
---
- hosts: tomcat
  become: yes
  roles:
    - tomcat_deploy
Roles folder
roles/
 └── tomcat_deploy/
      ├── tasks/
      │     └── main.yml
      └── files/
            └── sample.war   (dummy)
main.yml
---
- name: Stop Tomcat
  command: /opt/tomcat9/bin/shutdown.sh
  ignore_errors: yes

- name: Delete old WAR
  file:
    path: /opt/tomcat9/webapps/sample.war
    state: absent

- name: Copy new WAR
  copy:
    src: sample.war
    dest: /opt/tomcat9/webapps/sample.war

- name: Start Tomcat
  command: /opt/tomcat9/bin/startup.sh
________________________________________
GIT SETUP after creating the ansible folder to push to Github
________________________________________
✅ STEP 1 — Go to your project folder
cd ~/tomcat-deploy
________________________________________
✅ STEP 2 — Initialize Git (if not already initialized)
Run only once:
git init
________________________________________
✅ STEP 3 — Add your GitHub repo as origin
First remove old origin (if any):
git remote remove origin
Then add correct GitHub repo:
git remote add origin https://github.com/santhoshannadurai6256-dotcom/tomcat-ansible-jenkins.git
________________________________________
✅ STEP 4 — Add all files
git add .
________________________________________
✅ STEP 5 — Commit the files
git commit -m "Initial CI/CD project commit"
________________________________________
✅ STEP 6 — Create main branch (if not created)
git branch -M main
________________________________________
✅ STEP 7 — First-time pull (required if repo already has files)
Do this to avoid: “failed to push some refs” error.
git pull origin main --allow-unrelated-histories
If merge editor appears, type:
:wq
________________________________________
✅ STEP 8 — PUSH to GitHub
git push -u origin main
✅ When asked for login:
Username: your GitHub username
Password: your GitHub Personal Access Token (PAT)
(Not your GitHub password)
________________________________________
✅ If still rejected, use force push
(Use only when necessary)
git push -u origin main --force
________________________________________
✅ If you send me your current folder screenshot + any error
I will fix the Git push 100%.


✅ 7. JENKINS SERVER SETUP
Install Jenkins
sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo apt-add-repository "deb https://pkg.jenkins.io/debian binary/"
sudo apt install jenkins -y
sudo systemctl start jenkins
Access Jenkins:
http://<JENKINS_IP>:8080
________________________________________
✅ 8. INSTALL REQUIRED JENKINS PLUGINS
Go to:
✅ Manage Jenkins → Plugins → Available
Install:
•	Maven Integration
•	Git plugin
•	Pipeline
•	SSH Agent plugin
________________________________________
✅ 9. CONFIGURE MAVEN IN JENKINS
Manage Jenkins → Tools → Maven Installations
Name: Maven3
Install automatically: ✅
________________________________________
✅ 10. CONNECT JENKINS → ANSIBLE SERVER USING SSH
On Jenkins server:
Switch to Jenkins user:
sudo su - jenkins
Generate SSH Key:
ssh-keygen -t rsa
Copy key to Ansible server:
ssh-copy-id ubuntu@<ANSIBLE_IP>
Test:
ssh ubuntu@<ANSIBLE_IP>
✅ Should NOT ask password.
________________________________________
✅ 11. GITHUB PROJECT STRUCTURE
Your GitHub repo must look like:
tomcat-ansible-jenkins/
 ├── Jenkinsfile
 ├── inventory.ini
 ├── deploy.yml
 ├── pom.xml
 ├── roles/
 └── src/
________________________________________
✅ 12. CREATE pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.santhosh</groupId>
  <artifactId>sample-webapp</artifactId>
  <version>1.0</version>
  <packaging>war</packaging>

  <build>
    <finalName>sample</finalName>
    <plugins>
      <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-war-plugin</artifactId>
          <version>3.2.3</version>
          <configuration>
              <failOnMissingWebXml>false</failOnMissingWebXml>
          </configuration>
      </plugin>
    </plugins>
  </build>

</project>
________________________________________
✅ 13. CREATE SAMPLE WEB APP
index.jsp
src/main/webapp/index.jsp
Paste any HTML 
WEB-INF/web.xml
src/main/webapp/WEB-INF/web.xml
________________________________________
✅ 14. JENKINSFILE (FINAL WORKING VERSION)
pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    stages {

        stage('Build WAR') {
            steps {
                sh "mvn clean package"
            }
        }

        stage('Copy WAR to Ansible Server') {
            steps {
                sh "scp -o StrictHostKeyChecking=no target/sample.war ubuntu@3.110.204.162:/home/ubuntu/tomcat-deploy/roles/tomcat_deploy/files/"
            }
        }

        stage('Deploy to Tomcat using Ansible') {
            steps {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@3.110.204.162 'cd tomcat-deploy && ansible-playbook -i inventory.ini deploy.yml'"
            }
        }
    }
}
________________________________________
✅ 15. RUN THE PIPELINE
Go to Jenkins → Your Job → Build Now
Expected stages:
✅ Git Checkout
✅ Maven Build
✅ SCP WAR to Ansible
✅ Ansible Deployment
✅ Tomcat Restart
Pipeline result:
✅ SUCCESS
________________________________________
✅ 16. VERIFY THE APPLICATION
Open in browser:
http://<TOMCAT1_IP>:8080/sample/
http://<TOMCAT2_IP>:8080/sample/
You should see your index.jsp page.
________________________________________
✅ PROJECT COMPLETED 🎉

