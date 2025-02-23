pipeline {
    agent any

    environment {
        IMAGE_NAME = "danielsg22/node_exp"
    }

    stages{
        stage("Preporation"){
            steps{
                    sh "docker --version" && "docker-compose --version"
            }
        }
        stage("Docker build "){
            steps{
                sh "docker build -t $IMAGE_NAME ."
            }
        }
        stage('Run Tests') {
            steps {
                sh 'docker run --rm -d -p 3000:3000 $IMAGE_NAME'
            }
        }
        stage("Docker registry push"){
            steps{
                withDockerRegistry([credentialsId: 'docker-user', url:'']) {
                    sh "docker tag $IMAGE_NAME $IMAGE_NAME:latest"
                    sh "docker push $IMAGE_NAME:latest"
                }
            }
        }
        stage("Deploy to remote server"){
            steps{
                sshagent(['jenkins-ssh-key']) {
                    sh '''
                    ssh user@remote-server '
                    docker pull node_exp:latest &&
                    docker stop node_exp || true &&
                    docker rm node_expE || true &&
                    docker run -d --name node_exp -p 3000:3000 node_exp:latest
                    '
                    '''
                }
            }
        }


    }

}
