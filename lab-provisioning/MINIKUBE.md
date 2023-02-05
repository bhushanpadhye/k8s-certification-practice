# Minikube Single Node Cluster

<p>This will start a VirtualBox virtual machine that will contain a single node Kubernetes deployment and the Docker engine. Internally, minikube runs a single Go binary called localkube. This binary runs all the components of Kubernetes together. This makes Minikube simpler than a full Kubernetes deployment. In addition, the Minikube VM also runs Docker, in order to be able to run containers.</p>

#### Install Minikube 
<i>Note: These steps are for mac os. [For other OS follow these steps](https://minikube.sigs.k8s.io/docs/start/)</i>

1. Download minikube binaries
<pre><code>curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64</code></pre>

2. Install binaries to /usr/local/bin
<pre><code>sudo install minikube-darwin-amd64 /usr/local/bin/minikube</code></pre>

3. Update config to use hyperkit (my prefered approach)

    - Install hyperkit if not available
    <pre><code>brew install hyperkit</code></pre>

    - Update minikube config to use hyperkit
    <pre><code>minikube config set driver hyperkit</code></pre>

4. Start minikube cluster
<pre><code>minikube start</code></pre>

