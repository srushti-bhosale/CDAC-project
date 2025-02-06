pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "srush634/docker-webapp:latest"
        SONAR_HOST_URL = 'http://localhost:9000' 
    }
    
    stages {
        stage('SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/srushti-bhosale/CDAC-project.git'
            }
        }
        
        stage('SonarQube Analysis') {
            environment {
                SONAR_AUTH_TOKEN = credentials('sonarqube') 
            }
            steps {
                sh '/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=sample_project -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_AUTH_TOKEN'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "/usr/bin/docker image build -t ${DOCKER_IMAGE} ."
            }
        }
        
        stage('Scan Docker Image-Trivy') {
            steps {
                script {
                    // Run Trivy to scan the Docker image
                    def trivyOutput = sh(script: "trivy image ${DOCKER_IMAGE}", returnStdout: true).trim()

                    // Display Trivy scan results
                    println trivyOutput

                    // Check if vulnerabilities were found
                    if (trivyOutput.contains("Total: 0")) {
                        echo "No vulnerabilities found in the Docker image."
                    } else {
                        echo "Vulnerabilities found in the Docker image."
                        // Uncomment the next line to fail the pipeline if vulnerabilities are found
                        // error "Vulnerabilities found in the Docker image."
                    }
                }
            }
        }
        
        stage("Push Docker Image") {
            steps {
                withCredentials([string(credentialsId: 'DOCKER_HUB_TOKEN', variable: 'DOCKER_HUB_TOKEN')]) {
                    sh "echo $DOCKER_HUB_TOKEN | /usr/bin/docker login -u srush634 --password-stdin"
                    sh "/usr/bin/docker image push ${DOCKER_IMAGE}"
                }
            }
        }
        
        stage("Deploy Docker Service") {
            steps {
                sh "/usr/bin/docker rm backend || true"
                sh "/usr/bin/docker run -d --name backend -p 4000:80 ${DOCKER_IMAGE}"
            }
        }
    }
}

