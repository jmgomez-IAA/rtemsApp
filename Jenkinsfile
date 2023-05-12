//Jenkinsfile (Declarative Pipeline)

/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { 
        image 'juanmagomez/rtems_qdp:v1' 
        args '-u root:root'
        } }
    stages {
        stage('build') {
            steps {
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/example++/ && make'
            }
        }
        stage('test') {
            steps {
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/example++/ && make run'
            }
        }        
    }
}

