/**
 * Executes kubeconform linting on the specified Kubernetes manifests.
 *
 * @param manifests The Kubernetes manifests to lint.
 * @return The result of the linting process.
 */
def call(String k8s_manifests) {
    sh """
        #!/usr/bin/env bash
        set -euo pipefail

        kustomize_args=(
            "--load-restrictor=LoadRestrictionsNone"
            "--enable-helm"
        )
        kubeconform_args=(
            "-strict"
            "-ignore-missing-schemas"
            "-skip"
            "-schema-location"
            "default"
            "https://kubernetes-schemas.pages.dev/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json"
            "-verbose"
        )
        echo "=== Validating standalone manifests in ${k8s_manifests} ==="
        find "${k8s_manifests}" -maxdepth 1 -type f -name '*.yaml' -print0 | while IFS= read -r -d $'\0' file;
        do
            kubeconform "${kubeconform_args[@]}" "${file}"
            if [[ ${PIPESTATUS[0]} != 0 ]]; then
                exit 1
            fi
        done
    """
}