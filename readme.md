
This is my basic k8s at home stack. Features:

1. Self-Hosted Docker-Registry
2. Jenkins
3. certificate manager, with local CA service


Dependencies

1. You'll need provide terraform-provider-k8s, because it can do k8s manifests in TF
```
# Build custom k8s provider
git clone https://github.com/banzaicloud/terraform-provider-k8s.git
cd terraform-provider-k8s
go build
go install

# Add the following to ~/.terraformrc
#
providers {
  k8s = "/$GOPATH/bin/terraform-provider-k8s"
}

```

2. You need to make a certficates and place them in ~/.ssh :
```
mkdir ~/.ssl && pushd ~/.ssl
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=linuxguru.net" -days 3650 -reqexts v3_req -extensions v3_ca -out ca.crt
```

