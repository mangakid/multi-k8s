docker build -t mangakid/multi-client:latest -t mangakid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mangakid/multi-server:latest -t mangakid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mangakid/multi-worker:latest -t mangakid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mangakid/multi-client:latest
docker push mangakid/multi-server:latest
docker push mangakid/multi-worker:latest

docker push mangakid/multi-client:$SHA
docker push mangakid/multi-server:$SHA
docker push mangakid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mangakid/multi-server:$SHA
kubectl set image deployments/client-deployment client=mangakid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mangakid/multi-worker:$SHA