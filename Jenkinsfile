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
