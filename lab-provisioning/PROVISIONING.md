# Provisioning Lab Environment

## Local Cluster Setup 

### Pre-Requisites

- Oracle Virtual Box
- Vagrant
- kubectl

### Preparing lab environment

1. Go to folder [repo]/lab-provisioning/local-cluster

2. Run command:
 <pre><code>vagrant up</code></pre>
 
3. Once finished check status using command:
 <pre><code>vagrant status</code></pre>

 ![vagrant status](vagrant-status.png)

4. SSH into control plane using command:
 <pre><code>vagrant ssh control-plane-1</code></pre>

5. login as root user:
 <pre><code>sudo -i</code></pre>

6. Run kubeadmin init command:
 <pre><code>kubeadm init --apiserver-advertise-address=192.168.56.2 --control-plane-endpoint=192.168.56.2</code></pre>

7. From above command output note down kubeadm join command and run it on all worker nodes: 
 ![kubeadm init output](kubeadm-init.png)


8. To start using your cluster, you need to run the following as a regular user and copy ~/.kube/config as admin kube config file to your host:
<pre><code>
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
</code></pre>

9. Deploying pod network addon - Weave Net
<pre><code>
    kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
</code></pre>

10. The Dashboard UI is not deployed by default. To deploy it, run the following command:
<pre><code>
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
</code></pre>

11. [Create sample user following link](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md)

12. Run kubectl proxy on host machine to access dashboard
<pre><code>
 kubectl proxy
</code></pre>

Dashboard is available at [Dashboard Url](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)