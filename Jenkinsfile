pipeline {
    agent any
    tools {
        maven 'maven'
    }
    
    stages {
        stage('Build Maven') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/KingMicky/betatribe.git']]])
                sh 'mvn clean install'
            }
        }
        
        stage('Build docker image') {
            steps {
                script {
                    sh 'docker build -t alphatribe/kubernetes .'
                }
            }
        }
        stage('Push image to hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u suresh394 -p ${dockerhubpwd}'
                        
                    }
                }

        }
    }
}
