# Helm (Kubernetes) Interface

## What is this?

This is an opinionated helm chart. The goal is to cover a large amount of 
helm/kubernetes use cases without having to deal with helm templating chaos, 
many, mostly-duplicated helm charts and kubernetes resource 
definition complexities.  

Instead, we want to generate all the necessary definitions by only providing
a slimmed down configuration via helm values.

## Install

1. Install the helm repository by running  
   ```shell
   helm repo add helm-interface https://kickthemooon.github.io/helm-interface
   ```
2. Add it as a dependency to your `Chart.yaml`  
   ```yaml
   dependencies:
     - name: helm-interface
       version: 0.1.0
       repository: https://kickthemooon.github.io/helm-interface
       alias: interface
   ```

## Example Usage

```yaml
interface:
   defaults:
     image:
       registry: nginx
       tag: latest
   
   workloads:
     - name: nginx
       enabled: true
       deployment:
         enabled: true
         pod:
           containers:
             - name: nginx
               ports:
                 - containerPort: 80
                   service:
                     enabled: true
                   ingress:
                     enabled: true
                     tlds:
                       - .com
                     hosts:
                       prefix: www.example
                       paths:
                         - value: /
```

Providing the above configuration will generate
deployment, service and ingress definitions.

## Available Resources

These are the currently available kubernetes resources:

- Deployment
- Service
- Ingress
- ServiceAccount
- HorizontalPodAutoscaler
- ConfigMaps
- Secrets
- Job
- CronJob
- DaemonSet

## Full Configuration

To see all available configuration options check out [values-full.yaml](examples/values-full.yaml)
