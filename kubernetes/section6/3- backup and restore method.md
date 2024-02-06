## 쿠버네티스의 백업과 복구 방법
### 선언형으로 resource configuration 백업

```yaml
#pod.yaml
apiVersion: v1
kind Pod

metadata:
    name: muapp-pod
    labels:
        app: myapp
        type: front-end
spec:
    containers:
    - name: nginx-container
      image: nginx

# kubectl apply -f pod.yaml
```
- resource configuration 파일을 이용헤 백업해두고 재사용 가능하다.

`kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml`
- 위의 get all 명령어를 통해 모든 네임스페이스의 파드, 배포, 서비스를 가져와 yaml 파일에 추출하여 저장할 수도 있다.


### ETCD CLuster
- 하나의 클러스터를 백업용으로 두고 해당 클러스터 내부에 리소스를 백업함
- 클러스터 내부에 접근이 불가능한 문제가 발생할 수 있으므로 Kube API 서버를 백업하는 방법이 나을 수 있다.