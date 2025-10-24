# Node.js App with Prometheus Monitoring

##  Overview
This project demonstrates how to deploy a **Node.js** application on **Kubernetes** with integrated **Prometheus monitoring** and **Slack alerting** using the **Prometheus Operator stack**.

The setup includes:
- Node.js application containerized using Docker.
- Kubernetes Deployment and Service.
- Prometheus ServiceMonitor to scrape metrics.
- PrometheusRule to trigger alerts based on custom metrics.
- Alertmanager configuration to send alerts to a Slack channel.

---

##  Project Structure

.
├── Dockerfile
├── index.js
├── nodejs-alertManager.yml
├── nodejs-alertRule.yml
├── nodejs-app-slack-secret.yml
├── nodejs-app.yml
├── nodejs-svc-monitor.yml
└── nodejs-svc.yml

---

##  How It Works

1. **Dockerfile** builds a lightweight Node.js image that runs on port `3000`.
2. **Kubernetes Deployment** runs 3 replicas of the Node.js app.
3. **Service** exposes the app on port `32000` (NodePort).
4. **ServiceMonitor** scrapes metrics from the `/metrics` endpoint every 15 seconds.
5. **PrometheusRule** triggers an alert (`HighRequestRateNodejs`) if request rate > 10 reqs/5min.
6. **AlertmanagerConfig** sends the alert to a Slack channel.

---

##  Deployment Steps

1. **Build and push the image:**
   ```bash
   docker build -t 3mahmoud6/nodejs-app-prom:v1 .
   docker push 3mahmoud6/nodejs-app-prom:v1

    Deploy the app and monitoring stack:

kubectl apply -f deployment.yaml

Verify components:

    kubectl get pods
    kubectl get svc
    kubectl get servicemonitors -n monitoring
    kubectl get prometheusrules -n monitoring

 Monitoring & Alerts

    Metrics scraped at /metrics endpoint (via prom-client).

    Prometheus alert rule monitors the request rate.

    Alerts are sent to Slack channel #high_request_nodejs_app.

 Requirements

    Docker

    Kubernetes cluster (Minikube, kubeadm, or cloud provider)

    Prometheus Operator (Kube-prometheus-stack)
    
    Grafana (for better visualization)

    kubectl configured properly

 Notes

    Make sure the namespace monitoring exists and Prometheus Operator is installed.

    Replace the Slack webhook in the Secret before applying the YAML.

    You can modify alert thresholds and scrape intervals as needed
