What is pod? : 
	- A pod is smallest deployable unit in GKE. 
	- Pod will have one container or multiple container. 
	- If it has multicontainer then it shares resources

How to create a pod? : 
 	- Dynamically => using kubectl commands
	- Declaratively => using specifications in files in yaml and apply the configuration

ReplicaSets and Deployments : 
	ReplicaSets :
		1. Define stable set of replica pods
		2. Specify how many replicas we want
	ReplicaSet make sure that number of replicas we define is available, scheduling them to run in our nodes
		- Replicas are created in deployment object
        - How to create replicas ==> with deployment object

Service : Service is the k8s object that simply exposes the set of pods to the network
	Types of Service :
		1. Cluster IP : it assigns fix IP to k8s cluster and used for allowing services to talk to each other internally
		2. Node Port : assigns a specific port for your node in cluster
		3. Load Balancer : GCP load balancer to expose the service

Load Balanacer : 
	- A load balancer is a networking device or service that distributes incoming network traffic across multiple servers or computing resources, 
	  ensuring that no single server or resource is overwhelmed with excessive traffic. 
	- The primary purpose of a load balancer is to improve the availability, reliability, and scalability of applications or services by efficiently distributing workloads.
	
Ingress : 
	- way to configure the routing of HTTP and HTTPS traffic from outside the cluster to services running inside the cluster. 
	- Ingress acts as a layer of abstraction that simplifies the management of external access to multiple services by allowing 
	  you to define rules for routing traffic based on hostnames, paths, and other criteria.

Install Nginx Ingress Controller :
	- To install the Nginx Ingress Controller in Google Cloud Shell, you can use Helm, 
	- Helm : a package manager for Kubernetes. 
	
	Here are the steps to install the Nginx Ingress Controller:

	Open Google Cloud Shell:
		- Open the Google Cloud Console and navigate to the project where you want to install the Ingress Controller. 
		- Click the "Activate Cloud Shell" button at the top of the console to open a Cloud Shell session.

	Install Helm:
		- If you don't have Helm installed in your Cloud Shell, you can install it using the following commands:
		- curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 chmod +x get_helm.sh ./get_helm.sh
		- This installs Helm version 3, which is the latest version at the time of writing.

	Add the Helm Repository:
		- helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	
	- Configure cluster to Shell 

	Create a Namespace :
		- You can create a dedicated namespace for the Ingress Controller to isolate it from other resources:
		- kubectl create namespace ingress-nginx

	Install the Ingress Controller:
		- helm install my-ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx
		- Replace my-ingress-nginx with a name of your choice.

	Verify Installation:
		- kubectl get pods -n ingress-nginx
		- kubectl get svc -n ingress-nginx
	You should see the Ingress Controller pods running and a service with an external IP (if available).

	The Nginx Ingress Controller is now installed in your Google Cloud Shell and is ready to be used to manage Ingress resources for routing traffic in your Kubernetes cluster. 
	Remember to configure DNS and create Ingress resources as needed to route traffic to your applications.

Cloud DNS : 
	- Google Cloud DNS is a scalable and highly available Domain Name System (DNS) service provided by Google Cloud Platform (GCP). 
	- DNS is a fundamental component of the internet that translates human-friendly domain names (e.g., www.example.com) into IP addresses (e.g., 192.0.2.1) that computers use to locate and communicate with each other.

Create a Google Cloud DNS Zone :
	- Go to the Google Cloud DNS
	- In the left sidebar, navigate to "Network Services" > "Cloud DNS."
	- Click the "Create Zone" button.
	- Enter a Zone name, e.g., myapp-zone.
	- Enter a DNS name, e.g., example.com.
	- Click the "Create" button to create the DNS zone.

	Configure DNS Records :
		- Inside your DNS zone, click the "Add record set" button.
		- Leave the "Name" field blank to indicate the root domain (e.g., @).
		- For the "Resource record type," select "A."
		- Enter the IPv4 address of your Ingress Controller's external service. To find this IP address, use the following command:
			- kubectl get svc -n ingress-nginx my-ingress-nginx-controller
		- Leave the "TTL" at the default value.
	Click the "Create" button to create the DNS record.