package kubernetes.admission
 
import data.kubernetes.namespaces
 
operations = {"CREATE", "UPDATE"}
 
deny[msg] {
	input.request.kind.kind == "Pod"
	operations[input.request.operation]
	image := input.request.object.spec.containers[_].image
	image == "busybox"
	msg := sprintf("image not allowed %q", [image])
}
