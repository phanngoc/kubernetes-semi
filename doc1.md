## Kubernetes deployment strategies

Rolling deployment—the default strategy that allows you to update a set of pods without downtime. It replaces pods running the old version of the application with the new version, one by one.
Recreate deployment—an all-or-nothing method that lets you update an application instantly, with some downtime. It terminates all pods and replaces them with the new version.
Ramped slow rollout—rolls out replicas of the new version, while in parallel, shutting down old replicas. 
Best-effort controlled rollout—specifies a “max unavailable” parameter which indicates what percentage of existing pods can be unavailable during the upgrade, enabling the rollout to happen much more quickly.
Blue/green deployment—a deployment strategy in which you create two separate, but identical environments, and over to the new environment.
Canary deployment—uses a progressive delivery approach, with one version of the application serving most users, and another, newer version serving a small pool of test users. The test deployment is rolled out to more users if it is successful.
Shadow deployment—the new version of the application (the “shadow” version) receives real-world traffic alongside the current version, but without affecting end-users.
A/B testing—rolls out two or more versions of an application feature to a subset of users simultaneously to see which one performs better in terms of user engagement, error rates, or other KPIs.