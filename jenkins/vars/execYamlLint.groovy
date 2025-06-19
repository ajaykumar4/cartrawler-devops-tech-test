/**
 * Executes yamlint linting on the specified Kubernetes manifests.
 *
 * @param manifests The Kubernetes manifests to lint.
 * @return The result of the linting process.
 */
def call(String k8s_manifests) {
    sh "yamllint --strict ${k8s_manifest}"
}