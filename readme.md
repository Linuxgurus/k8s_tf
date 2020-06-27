
## This is my basic k8s at home stack. Features:

1. Self-Hosted Docker-Registry
2. Jenkins
3. certificate manager, with local CA service

# Using the prototype stack

Please see using_the_prototype.md on instructions on how to gain access to
the prototype

# Standing this up

## Dependencies

1. The terraform-provider-k8s provider, for apply k8s manifests in K8s
```
# Build custom k8s provider
git clone https://github.com/banzaicloud/terraform-provider-k8s.git
cd terraform-provider-k8s
go build
go install

# Add this  to ~/.terraformrc
providers {
  k8s = "/$GOPATH/bin/terraform-provider-k8s"
}

```

2. You need to make a certficates and place them in ~/.ssh :
```
export MYCN="linuxguru.net"
mkdir ~/.ssl && cd ~/.ssl
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=$MYCN" -days 820 -reqexts v3_req -extensions v3_ca -out ca.crt
```

## Installation:

1. run tf apply
2. run tf apply a second time, because of this bug:
https://github.com/banzaicloud/terraform-provider-k8s/issues/47

