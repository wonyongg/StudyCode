### 쿠버네티스 패키지 구성 요소 버전 관리
kube-apiserver : X
Controller-manager, kube-scheduler : X-1 버전까지 가능, kube-apiserver보다 높을 수는 없다.
kubelet, kuber-proxy : X-2 버전까지 가능, kube-apiserver보다 높을 수는 없다.

kubectl: X-1 ~ X+1까지 가능

### 클러스터 업그레이드 예시
마스터 노드 1, 워커 노드가 3개 있는 상황

공식 홈페이지에서 업그레이드 가능 안정화 버전 찾기
(ex) v1.11.3 -> v1.12.0으로 업글하기로 결정

#### 마스터 노드(Control Plane) 업그레이드
##### kubeadm upgrade
apt-get update
apt-get install kubeadm=1.12.0.-00
kubeadm version
kubeadm upgrade plan : 다운로드 받은 업그레이드 가능 버전, 안정화 버전 등 확인 가능 
kubeadm upgrade apply v1.12.0
kube get nodes : 컨트롤 플레인 버전은 그대로일 것 이것은 kubelet 버전을 보여주기 때문, 수동으로 업그레이드해줘야함

##### 마스터 노드(Control Plane) 업그레이드
kubectl drain controlplane --ignore-daemonsets
apt-get install kubelet=1.12.0.-00
systemctl daemon-reload
systemctl restart kubelet
kubectl get nodes(업데이트 됨을 확인 가능)

#### 워커 노드 업그레이드
apt-get update
apt-get install kubeadm=1.27.0-00
kubeadm upgrade node(node이름 아님 그냥 node)

kubectl drain node-1 --igonre-daemonsets
apt-get install kubelet=1.27.0-00 
kubeadm upgrade node config --kubelet=version v1.27.0
systemctl daemon-reload
systemctl restart kubelet
kubectl uncordon node-1
kubectl drain node-2
...(반복)
kubectl uncordon node-2
kubectl drain node-3
...(반복)
kubectl uncordon node-3
