apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  name: ${name}
spec:
  secretName: ${name}
  duration: 21600h 
  renewBefore: 360h 
  keyAlgorithm: rsa
  keyEncoding: pkcs1
  usages:
    - server auth
  dnsNames:
%{ for s in hostnames ~}
  - ${s}
%{ endfor ~}
  issuerRef:
    name: ${issuer}
    kind: Issuer

