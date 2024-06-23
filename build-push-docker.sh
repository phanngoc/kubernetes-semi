#!/bin/bash
eval $(minikube -p minikube docker-env)

# Store the list of containers to a variable
containers=$(docker ps -a -q --filter "name=nodejs-express-app")

# Check if the variable is not empty
if [ ! -z "$containers" ]; then
    docker rm -f $containers
fi

cd app && docker build -t nodejs-express-app .
cd ..

docker tag nodejs-express-app:latest phann123/nodejs-express-app:latest
docker push phann123/nodejs-express-app:latest