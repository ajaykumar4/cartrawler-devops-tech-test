/**
 * Executes ECR login for Docker.
 *
 * This function retrieves the ECR login password and authenticates the Docker client to the ECR registry.
 *
 * @return void
 */
def call(String aws_credential_id, String aws_region, String aws_ecr_registry) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: aws_credential_id]]) {
        sh """
        aws sts get-caller-identity
        aws ecr get-login-password --region ${aws_region} | \
        docker login --username AWS --password-stdin ${aws_ecr_registry}
        """
    }
}
