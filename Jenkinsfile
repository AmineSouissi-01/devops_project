pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub_login')
        SONAR = credentials('sonar_token')
        SONAR_HOST_URL = "http://192.168.1.73:9000"
        IMAGE_NAME = "timesheet-devops"
    }

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AmineSouissi-01/devops_project.git'
            }
        }

        stage('Build clean') {
            steps {
                sh "mvn clean"
            }
        }

        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }

        stage('Package') {
            steps {
                sh "mvn package -DskipTests"
            }
        }

        stage('Install') {
            steps {
                sh "mvn install -DskipTests"
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=devops_project \
                        -Dsonar.host.url=${SONAR_HOST_URL} \
                        -Dsonar.login=${SONAR}
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "echo ${DOCKERHUB_PSW} | docker login -u ${DOCKERHUB_USR} --password-stdin"
                sh "docker tag ${IMAGE_NAME}:latest ${DOCKERHUB_USR}/${IMAGE_NAME}:latest"
                sh "docker push ${DOCKERHUB_USR}/${IMAGE_NAME}:latest"
            }
        }
    }
}
