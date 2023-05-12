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
                sh 'rmdir /opt/rtems-6-sparc-gr712rc-smp-4/src/app'
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/ && ln -s /var/jenkins_home/workspace/rtemsApp_main app'
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/app/ && make'
                sh 'ls /opt/rtems-6-sparc-gr712rc-smp-4/src/app/'
            }
        }
        stage('test') {
            steps {
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/app/ && make run'
            }
        }        
    }
}

