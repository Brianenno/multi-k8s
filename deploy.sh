docker build -t brianenno/multi-client:latest -t brianenno/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brianenno/multi-server:latest -t brianenno/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brianenno/multi-worker:latest -t brianenno/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brianenno/multi-client:latest
docker push brianenno/multi-server:latest
docker push brianenno/multi-worker:latest

docker push brianenno/multi-client:$SHA
docker push brianenno/multi-server:$SHA
docker push brianenno/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brianenno/multi-server:$SHA
kubectl set image deployments/client-deployment client=brianenno/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brianenno/multi-worker:$SHA