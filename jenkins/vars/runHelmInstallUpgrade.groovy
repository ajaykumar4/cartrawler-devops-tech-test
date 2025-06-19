/**
 * Runs a Helm install or upgrade for the specified release and chart.
 *
 * @param releaseName The name of the Helm release.
 * @param chartPath The path to the Helm chart.
 * @param namespace The Kubernetes namespace to deploy the release.
 * @param imageTag The Docker image tag to use for the release.
 */
def runHelmInstallUpgrade(String releaseName, String chartPath, String namespace, String imageTag, String imageRepository) {
    sh """
        helm upgrade --install ${releaseName} ${chartPath} \
            --namespace ${namespace} \
            --set image.tag=${imageTag} \
            --set image.repository=${imageRepository} \
            -- create-namespace \
            --timeout 10m \
            --atomic 
    """
}
