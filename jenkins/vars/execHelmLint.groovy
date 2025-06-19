/**
 * Executes helm linting on the specified Kubernetes manifests.
 *
 * @param manifests The Kubernetes manifests to lint.
 * @return The result of the linting process.
 */
def call(String helm_manifests) {
    sh "helm lint ${helm_manifests}"
}