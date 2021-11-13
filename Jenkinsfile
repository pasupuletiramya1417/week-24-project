pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }
    

    stages {
         stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/kranthikk96/week-24-project.git"
                        }
                    }
                }
         }
       
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                }
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment}'
                sh 'terraform plan -input=false'
                
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
           steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: 'plan')]
                }
            }
        }

        stage('Apply') {
            steps {
                sh "terraform apply -input=false -auto-approve"
                sh "terraform destroy -input=false -auto-approve"
            }
        } 
    }
}
