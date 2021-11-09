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
            }
        }
		      }
        stage ('Release') {
           steps {
		script {
			def apply = true
			def status = null
			try {
			 status = sh(script: "aws cloudformation describe-stacks --stack-name WEBAPP-${STACK_ENV} \
				--query Stacks[0].StackStatus --output text --profile ${PROFILE}", returnStdout: true)
				  apply = true
				 } catch (err) {
						apply = false
						sh 'echo Creating WEBAPP-${STACK_ENV}....'
						sh "aws cloudformation validate-template --template-body file://`pwd`/cloudformation.yml --profile ${PROFILE}"
						sh "aws cloudformation create-stack --stack-name WEBAPP-${STACK_ENV} --template-body \
										 file://`pwd`/cloudformation.yml --parameters file://`pwd`/${ENV}.json --profile ${PROFILE}"
						sh "aws cloudformation wait stack-create-complete --stack-name WEBAPP-${STACK_ENV} --profile ${PROFILE}"
						sh "aws cloudformation describe-stack-events --stack-name WEBAPP-${STACK_ENV} \
											--query 'StackEvents[].[{Resource:LogicalResourceId,Status:ResourceStatus,Reason:ResourceStatusReason}]' \
											--output table --profile ${PROFILE}"
					    }
					    if (apply) {
							try {
									sh "echo Stack exists, attempting update..."
									sh "aws cloudformation update-stack --stack-name \
											WEBAPP-${STACK_ENV} --template-body file://`pwd`/cloudformation.yml \
											--parameters file://`pwd`/${ENV}.json --profile ${PROFILE}"
							} catch (error) {
									sh "echo Finished create/update - no updates to be performed"
							}
					}
					sh "echo Finished create/update successfully!"
				}
                         }
		    }
    }
}
