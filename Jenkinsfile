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
                sh 'whoami'
                sh 'ls  /opt/rtems-6-sparc-gr712rc-smp-4/src/example++/'
                sh 'ls -la'
                sh 'pwd'
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/example++/ && make'
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/ && ln -s /opt/rtems-6-sparc-gr712rc-smp-4/src/app app'
                sh 'ls /opt/rtems-6-sparc-gr712rc-smp-4/src/app/'
            }
        }
        stage('test') {
            steps {
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/example++/ && make run'
            }
        }        
    }
}

