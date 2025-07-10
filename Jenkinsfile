pipeline {
    agent any

    environment {
        JAVA_HOME = "C:\\Program Files\\Java\\jdk-17"
        PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"
        BUILD_DIR = "target"
        JAR_FILE = "target\\springbootapp.jar"
        IMAGE_NAME = "my-springboot-app"
        CONTAINER_NAME = "springboot-container"
        DOCKERFILE_DIR = "."  // thư mục chứa Dockerfile
        PORT = "8080"
    }

    stages {
        stage('Clone') {
            steps {
                echo '📥 Cloning repository...'
                git branch: 'main', url: 'https://github.com/dangde-afk/ci-cd.git'
            }
        }

        stage('Build') {
            steps {
                echo '🛠 Building with Maven...'
                bat '.\\mvnw clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                bat '.\\mvnw test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                bat """
                    docker build -t ${IMAGE_NAME} ${DOCKERFILE_DIR}
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running container...'
                bat """
                    docker stop ${CONTAINER_NAME} || echo Not running
                    docker rm ${CONTAINER_NAME} || echo Not exist
                    docker run -d -p ${PORT}:${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
                """
            }
        }

        stage('Open Website') {
            steps {
                echo '🌐 Opening browser...'
                bat "start http://localhost:${PORT}"
            }
        }
    }
}