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
                sh 'ln -s /var/jenkins_home/workspace/rtemsApp_main app'
                //dir('/opt/rtems-6-sparc-gr712rc-smp-4/src/app')
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/app && make'
            }
        }
        stage('test') {
            steps {
                //dir('/opt/rtems-6-sparc-gr712rc-smp-4/src/app')
                sh 'cd /opt/rtems-6-sparc-gr712rc-smp-4/src/app && make run'
            }
        }        
    }
}

