pipeline {
    agent {
     kubernetes {
       yamlFile 'AgentPod.yaml'
         }
    }
    environment{
        AI_RESEARCH_SAAMA = '381743254372'
        LSACONE_DEV = '791532114280'
    }
    stages {
        stage('Assume Role in Dev') {
            steps {
                container('swashikan'){
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'app.jenkins.ecr-migration',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        withAWS(roleAccount: '381743254372', role: 'arn:aws:iam::381743254372:role/app.jenkins.ecr-migration.role') {
                            sh '''
                                for id in ${Source_Image_Tag[@]}; 
                                do
                                    aws ecr get-login-password --region ${Source_AWS_Region} | podman login --username AWS --password-stdin ${LSACONE_DEV}.dkr.ecr.${Source_AWS_Region}.amazonaws.com
                                    podman pull ${LSACONE_DEV}.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_ECR_Repo}:${id}
                                    echo ${LSACONE_DEV}.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_ECR_Repo}:${id} > test.txt
                                    unset AWS_ACCESS_KEY_ID
                                    unset AWS_SECRET_ACCESS_KEY
                                done                                                     
                            '''                            
                        }
                    }
                }
              }
            }
        }
    }
}
