pipeline {
    agent any

    environment {
        JAVA_HOME = "C:\\Program Files\\Java\\jdk-17" // Đường dẫn JDK 17
        PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"
        BUILD_DIR = "target"
        DEPLOY_JAR = "target\\springbootapp.jar"  // Tên jar của bạn
        DEPLOY_DIR = "C:\\wwwroot\\springboot"
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

        stage('Publish') {
            steps {
                echo '📦 Publishing artifact...'
                // Copy JAR sang thư mục publish
                bat """
                    if not exist ${DEPLOY_DIR} mkdir ${DEPLOY_DIR}
                    copy ${DEPLOY_JAR} ${DEPLOY_DIR}\\app.jar /Y
                """
            }
        }

        stage('Deploy to IIS') {
            steps {
                echo '🚀 Deploying...'
                bat '''
                    iisreset /stop
                    taskkill /F /IM java.exe || echo Java not running
                '''
                
                // Dùng PowerShell tạo IIS site nếu chưa có
                powershell '''
                    Import-Module WebAdministration
                    if (-not (Test-Path IIS:\\Sites\\SpringApp)) {
                        New-Website -Name "SpringApp" -Port 8080 -PhysicalPath "C:\\wwwroot\\springboot"
                    }
                '''

                // Chạy ứng dụng Spring Boot trong background
                bat 'start /B java -jar C:\\wwwroot\\springboot\\app.jar'
            }
        }

        stage('Open website') {
            steps {
                echo '🌐 Opening browser...'
                bat 'start http://localhost:8080/'
            }
        }
    }
}
