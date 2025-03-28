pipeline {
    agent {
        label "blogging_app" 
    }

    tools {
        jdk "jdk17"
        maven "maven3"
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage("Git Checkout") {
            steps {
                git(
                    branch: "master",
                    credentialsId: "git-credentials",
                    url: "https://github.com/VuPlayBoizz/Blogging-App.git"
                )
                sh "git rev-parse --short HEAD > commit-id"
            }
        }

        stage("Load application properties") {
            steps {
                withCredentials([file(credentialsId: 'application-properties', variable: 'APPLICATION_PROPERTIES')]) {
                    script {
                        sh 'sudo chmod -R 775 /home/ubuntu/jenkins_agent/workspace/Blogging-App'
                        sh "cp -f ${APPLICATION_PROPERTIES} src/main/resources/application.properties"
                    }
                }
            }
        }

        stage("Compile Code") {
            steps {
                sh "mvn clean compile"
            }
        }

        stage("Unit Test") {
            steps {
               sh "mvn test"
            }
        }

        stage("File System Scan") {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html . " 
            }            
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                        ${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectName=Blogging_App \
                        -Dsonar.projectKey=Blogging_App \
                        -Dsonar.java.binaries=.
                    '''
                }
            }
        }

        stage("Quality Gate") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, 
                    credentialsId: 'sonar-credentials'
                }
            }
        }

        stage("Build") {
            steps {
                sh "mvn package"
            }
        } 

        stage('Publish to Nexus') {
            steps {
                withMaven(globalMavenSettingsConfig: 'maven-settings', 
                          jdk: 'jdk17', 
                          maven: 'maven3', 
                          mavenSettingsConfig: '', 
                          traceability: true) {
                    sh "mvn deploy -DskipTests -DuniqueVersion=false"
                }
            }
        }      
    }
}
