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
        
        stage('Push image to hub') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')
                    ]) {
                        sh 'docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD'
                        sh 'docker push alphatribe/kubernetes'
                    }
                }

        }
        stage('Deploy to K8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'kubeconfig')
                }
            }
        }
    
    }    
}
