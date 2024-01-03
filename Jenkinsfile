podTemplate(
  containers: [
    containerTemplate(
      name: 'swashikan', 
      image: '791532114280.dkr.ecr.us-east-1.amazonaws.com/swashikan:lsacone',
      command: 'cat',
      ttyEnabled: true,
      resourceLimitEphemeralStorage: '50Gi',
      resourceLimitMemory: '8Gi'
    )
  ],
  volumes: [
    dynamicPVC(requestsSize : '500Gi', mountPath: '/var/lib/containers/storage/vfs')
  ]
) 

{
  node(POD_LABEL) {
    stage('Pull Source Image'){
      container('swashikan'){
        script {
                        def files = params.Source_ECR_Repo_and_Image_Tags.split('\n')                    
                        for (Source_Image_Tag in files) {
                            echo "Pulling ${Source_Image_Tag} on ${Source_AWS_Region}"
                            if (params.SOURCE_AWS_ACCOUNT == 'lsacone-dev') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration'
                                ]]) {
                                    sh """
df -h
                                        aws ecr get-login-password --region ${Source_AWS_Region} | podman login --username AWS --password-stdin 791532114280.dkr.ecr.${Source_AWS_Region}.amazonaws.com
                                        podman pull 791532114280.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag}
                                        echo 791532114280.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag} >> images.txt
                                        unset AWS_ACCESS_KEY_ID
                                        unset AWS_SECRET_ACCESS_KEY
                                        cat images.txt
df -h
                                    """
                                }                       
                            } else if (params.SOURCE_AWS_ACCOUNT == 'ai-research-saama') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                ]]) {
                                    withAWS(roleAccount: '381743254372', role: 'arn:aws:iam::381743254372:role/app.jenkins.ecr-migration.role') {
                                        sh """
df -h
                                            aws ecr get-login-password --region ${Source_AWS_Region} | podman login --username AWS --password-stdin 381743254372.dkr.ecr.${Source_AWS_Region}.amazonaws.com
                                            podman pull 381743254372.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag}
                                            echo 381743254372.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag} >> images.txt
                                            unset AWS_ACCESS_KEY_ID
                                            unset AWS_SECRET_ACCESS_KEY 
                                            cat images.txt
df -h
                                        """
                                    }
                                }
                            } else if (params.SOURCE_AWS_ACCOUNT == 'sdq-sam') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                ]]) {
                                    withAWS(roleAccount: '351054065682', role: 'arn:aws:iam::351054065682:role/app.jenkins.ecr-migration.role') {
                                        sh """
df -h
                                            aws ecr get-login-password --region ${Source_AWS_Region} | podman login --username AWS --password-stdin 351054065682.dkr.ecr.${Source_AWS_Region}.amazonaws.com
                                            podman pull 351054065682.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag}
                                            echo 351054065682.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag} >> images.txt
                                            unset AWS_ACCESS_KEY_ID 
                                            unset AWS_SECRET_ACCESS_KEY
                                            cat images.txt
df -h
                                        """
                                    }
                                }
                            } else if (params.SOURCE_AWS_ACCOUNT == 'sdq-preview') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                ]]) {
                                    withAWS(roleAccount: '846636829144', role: 'arn:aws:iam::846636829144:role/app.jenkins.ecr-migration.role') {
                                        sh """
df -h
                                            aws ecr get-login-password --region ${Source_AWS_Region} | podman login --username AWS --password-stdin 846636829144.dkr.ecr.${Source_AWS_Region}.amazonaws.com
                                            podman pull 846636829144.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag}
                                            echo 846636829144.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag} >> images.txt
                                            unset AWS_ACCESS_KEY_ID 
                                            unset AWS_SECRET_ACCESS_KEY
                                            cat images.txt
df -h
                                        """
                                    }
                                }
                            }
                        }    
      }
    }
  }
        stage('Push Destination Image'){
                container('swashikan'){
                    script{
                        def filess = params.Destination_ECR_Repo_and_Image_Tags.split('\n')                    
                        for (Destination_Image_Tag in filess) {
                            echo "Pushing ${Destination_Image_Tag} on ${Destination_AWS_Region}"
                            if (params.DESTINATION_AWS_ACCOUNT == 'lsacone-dev') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration'
                                ]]) {
                                    def SOURCE_TAG = sh(script: 'head -n 1 images.txt', returnStdout: true).trim()   
                                    sh """
                                        podman tag ${SOURCE_TAG} 791532114280.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                        echo 791532114280.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                        aws ecr get-login-password --region ${Destination_AWS_Region} | podman login --username AWS --password-stdin 791532114280.dkr.ecr.${Destination_AWS_Region}.amazonaws.com
                                        podman push 791532114280.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                        unset AWS_ACCESS_KEY_ID
                                        unset AWS_SECRET_ACCESS_KEY
                                        cat images.txt
                                        tail -n +2 images.txt > tmp.txt && mv tmp.txt images.txt
                                        cat images.txt                                       
                                    """
                                }                       
                            } else if (params.DESTINATION_AWS_ACCOUNT == 'ai-research-saama') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                ]]) {
                                    withAWS(roleAccount: '381743254372', role: 'arn:aws:iam::381743254372:role/app.jenkins.ecr-migration.role') {
                                        def SOURCE_TAG = sh(script: 'head -n 1 images.txt', returnStdout: true).trim()   
                                        sh """
                                            podman tag ${SOURCE_TAG} 381743254372.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}                   
                                            echo 381743254372.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                            aws ecr get-login-password --region ${Destination_AWS_Region} | podman login --username AWS --password-stdin 381743254372.dkr.ecr.${Destination_AWS_Region}.amazonaws.com
                                            podman push 381743254372.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                            unset AWS_ACCESS_KEY_ID
                                            unset AWS_SECRET_ACCESS_KEY
                                            cat images.txt
                                            tail -n +2 images.txt > tmp.txt && mv tmp.txt images.txt
                                            cat images.txt                                       
                                        """
                                    }
                                }
                            } else if (params.DESTINATION_AWS_ACCOUNT == 'sdq-sam') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                ]]) {
                                    withAWS(roleAccount: '351054065682', role: 'arn:aws:iam::351054065682:role/app.jenkins.ecr-migration.role') {
                                        def SOURCE_TAG = sh(script: 'head -n 1 images.txt', returnStdout: true).trim()   
                                        sh """
                                            podman tag ${SOURCE_TAG} 351054065682.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}                   
                                            echo 351054065682.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                            aws ecr get-login-password --region ${Destination_AWS_Region} | podman login --username AWS --password-stdin 351054065682.dkr.ecr.${Destination_AWS_Region}.amazonaws.com
                                            podman push 351054065682.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                            unset AWS_ACCESS_KEY_ID
                                            unset AWS_SECRET_ACCESS_KEY
                                            cat images.txt
                                            tail -n +2 images.txt > tmp.txt && mv tmp.txt images.txt
                                            cat images.txt                                       
                                        """
                                    }
                                }
                            } else if (params.DESTINATION_AWS_ACCOUNT == 'sdq-preview') {
                                withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'app.jenkins.ecr-migration',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                ]]) {
                                    withAWS(roleAccount: '846636829144', role: 'arn:aws:iam::846636829144:role/app.jenkins.ecr-migration.role') {
                                        def SOURCE_TAG = sh(script: 'head -n 1 images.txt', returnStdout: true).trim()   
                                        sh """
                                            podman tag ${SOURCE_TAG} 846636829144.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}                   
                                            echo 846636829144.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                            aws ecr get-login-password --region ${Destination_AWS_Region} | podman login --username AWS --password-stdin 846636829144.dkr.ecr.${Destination_AWS_Region}.amazonaws.com
                                            podman push 846636829144.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                            unset AWS_ACCESS_KEY_ID
                                            unset AWS_SECRET_ACCESS_KEY
                                            cat images.txt
                                            tail -n +2 images.txt > tmp.txt && mv tmp.txt images.txt
                                            cat images.txt                                       
                                        """
                                    }
                                }
                            } 
                        }    
                    }
            }
        }
}
}
