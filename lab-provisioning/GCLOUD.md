# Provisioning GKE cluster

Google takes every Kubernetes release through rigorous testing and makes it available via its GKE service. To be able to use GKE, you will need the following:

- An account on Google Cloud.
- A method of payment for services you will use.
- [The gcloud command line client](https://cloud.google.com/sdk/docs/install).

#### Command line can be used to start a GKE cluster
<pre><code>gcloud container clusters create \
  --machine-type n1-standard-2 \
  --num-nodes 2 \
  --zone us-east1-c\
  --cluster-version latest \
  lfs-cka-labs</code></pre> 

<i>This will automatically update your kube configuration file ~/.kube/config and set above cluster as current context</i>

<i>Google provides [Free Tier](https://cloud.google.com/free) for practice with $300 credit for 3 months. Please go through its term and conditions.</i>