docker build -t aniekannu/multi-client:latest -t aniekannu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aniekannu/multi-server:latest -t aniekannu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aniekannu/multi-worker:latest -t aniekannu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aniekannu/multi-client:latest
docker push aniekannu/multi-server:latest
docker push aniekannu/multi-worker:latest

docker push aniekannu/multi-client:$SHA
docker push aniekannu/multi-server:$SHA
docker push aniekannu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aniekannu/multi-server:$SHA
kubectl set image deployments/client-deployment client=aniekannu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aniekannu/multi-worker:$SHA

