setup-local-k8s-cluster:
	(brew list | grep kind) || brew install kind
	(kind get clusters | grep kind) || kind create cluster -n kind
	kind get kubeconfig > ./.kubeconfig
test-terraform-modules:
    terraform init \
    && terraform workspace select test || terraform workspace new test  \
    && terraform apply -auto-approve -target module.argocd_install \
    && (kubectl --kubeconfig=./.kubeconfig port-forward svc/argocd-server -n argocd 8080:443 &) \
    |  terraform apply -auto-approve -target module.argocd_setup_application \
    &&  echo "\n\n[Notice] Port forward to ArgoCD is running.\n $$(ps -ef | grep ' port-forward ' | grep -v grep)"
