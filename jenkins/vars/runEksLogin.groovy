/**
 * Runs an EKS login command using the specified AWS credentials.
 *
 * @param awsCredentialsId The ID of the AWS credentials to use.
 */
def runEksLogin(String awsCredentialsId, String cluster_name, String aws_region) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: awsCredentialsId]]) {
        sh """
            aws sts get-caller-identity
            aws eks update-kubeconfig --name ${cluster_name} --region ${aws_region}
        """
    }
}
