/**
 * Runs a Helm rollback for the specified release and namespace.
 *
 * @param releaseName The name of the Helm release to rollback.
 * @param namespace The Kubernetes namespace where the release is deployed.
 */
def runHelmRollback(String releaseName, String namespace) {
    sh "helm rollback ${releaseName} -n ${namespace} || echo 'No previous release to rollback to'"
}
