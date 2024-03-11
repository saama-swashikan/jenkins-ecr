podTemplate(
    containers: [
        containerTemplate(
            name: 'swashikan', 
            image: '791532114280.dkr.ecr.us-east-1.amazonaws.com/swashikan:lsacone',
            command: 'cat',
            ttyEnabled: true,
            resourceLimitEphemeralStorage: '50Gi',
            resourceLimitMemory: '16Gi'
        )
    ],
    volumes: [
        dynamicPVC(
            requestsSize : '300Gi', 
            mountPath: '/var/lib/containers/storage/vfs'
        )
    ]
) 
{
    properties([
        parameters([
        choice(
            name: 'SOURCE_AWS_ACCOUNT', 
            choices:'ai-research-saama\nlsacone-dev\nsdqsam\nsdqpreview\nschpreview', 
            description:'Select Source AWS Account'
        ),
        string(
            name: 'Source_AWS_Region',
            defaultValue: 'us-east-1',
            description: "Mention the Source aws account region which will be as: \nap-south-1 "
        ),
        text(
            name: 'Source_ECR_Repo_and_Image_Tags',
            description: "Mention the Source AWS Repository with Image Tag which will be as: ECR-Repository:Image-Tag \nlsac-sit-sdq:tag-213-23234-3\nairflow:tag-456032434\nsdq:tag-5643-344-425 \nMake Sure There is No Space at the end of each line "
        ), 
        choice(
            name: 'DESTINATION_AWS_ACCOUNT', 
            choices:'ai-research-saama\nlsacone-dev\nsdqsam\nsdqpreview\nschpreview', 
            description:'Select Destination AWS Account'
        ), 
        string(
            name: 'Destination_AWS_Region',
            defaultValue: 'us-east-1',
            description: "Mention the Destination aws account region which will be as: \nap-south-1 "
        ),
        text(
            name: 'Destination_ECR_Repo_and_Image_Tags',
            description: "Mention the Destination AWS Repository with Image Tag which will be as: ECR-Repository:Image-Tag \nlsac-sit-sdq:tag-213-23234-3-new\nairflow:tag-456032434-new\nsdq:tag-5643-344-425-new \nMake Sure There is No Space at the end of each line "
        )        
        ])
    ])
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
                                echo ${isnor}
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
                        } else if (params.SOURCE_AWS_ACCOUNT == 'sdqsam') {
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
                        } else if (params.SOURCE_AWS_ACCOUNT == 'sdqpreview') {
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
                        } else if (params.SOURCE_AWS_ACCOUNT == 'schpreview') {
                            withCredentials([[
                            $class: 'AmazonWebServicesCredentialsBinding',
                            credentialsId: 'app.jenkins.ecr-migration',
                            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                            ]]) {
                                withAWS(roleAccount: '764100877844', role: 'arn:aws:iam::764100877844:role/app.jenkins.ecr-migration.role') {
                                    sh """
                                        df -h
                                        aws ecr get-login-password --region ${Source_AWS_Region} | podman login --username AWS --password-stdin 764100877844.dkr.ecr.${Source_AWS_Region}.amazonaws.com
                                        podman pull 764100877844.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag}
                                        echo 764100877844.dkr.ecr.${Source_AWS_Region}.amazonaws.com/${Source_Image_Tag} >> images.txt
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
                        } else if (params.DESTINATION_AWS_ACCOUNT == 'sdqsam') {
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
                        } else if (params.DESTINATION_AWS_ACCOUNT == 'sdqpreview') {
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
                        } else if (params.DESTINATION_AWS_ACCOUNT == 'schpreview') {
                            withCredentials([[
                            $class: 'AmazonWebServicesCredentialsBinding',
                            credentialsId: 'app.jenkins.ecr-migration',
                            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                            ]]) {
                                withAWS(roleAccount: '764100877844', role: 'arn:aws:iam::764100877844:role/app.jenkins.ecr-migration.role') {
                                    def SOURCE_TAG = sh(script: 'head -n 1 images.txt', returnStdout: true).trim()   
                                    sh """
                                        podman tag ${SOURCE_TAG} 764100877844.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}                   
                                        echo 764100877844.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
                                        aws ecr get-login-password --region ${Destination_AWS_Region} | podman login --username AWS --password-stdin 764100877844.dkr.ecr.${Destination_AWS_Region}.amazonaws.com
                                        podman push 764100877844.dkr.ecr.${Destination_AWS_Region}.amazonaws.com/${Destination_Image_Tag}
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
