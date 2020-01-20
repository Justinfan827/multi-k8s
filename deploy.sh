docker build -t jfan827/multi-client:latest -t jfan827/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jfan827/multi-server:latest -t jfan827/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jfan827/multi-worker:latest -t jfan827/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jfan827/multi-client:latest
docker push jfan827/multi-client:$SHA
docker push jfan827/multi-server:latest
docker push jfan827/multi-server:$SHA
docker push jfan827/multi-worker:latest
docker push jfan827/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jfan827/multi-client:$SHA
kubectl set image deployments/server-deployment server=jfan827/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jfan827/multi-worker:$SHA
