docker build -t rok0sbasilisk/multi-client:latest -t rok0sbasilisk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rok0sbasilisk/multi-server:latest -t rok0sbasilisk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rok0sbasilisk/multi-worker:latest -t rok0sbasilisk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rok0sbasilisk/multi-client:latest
docker push rok0sbasilisk/multi-server:latest
docker push rok0sbasilisk/multi-worker:latest

docker push rok0sbasilisk/multi-client:$SHA
docker push rok0sbasilisk/multi-server:$SHA
docker push rok0sbasilisk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rok0sbasilisk/multi-server:$SHA
kubectl set image deployments/client-deployment client=rok0sbasilisk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rok0sbasilisk/multi-worker:$SHA
