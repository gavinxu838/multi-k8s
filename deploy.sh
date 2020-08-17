docker build -t gavinxu838/multi-client:latest -t gavinxu838/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gavinxu838/multi-server:latest -t gavinxu838/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gavinxu838/multi-worker:latest -t gavinxu838/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gavinxu838/multi-client:latest
docker push gavinxu838/multi-server:latest
docker push gavinxu838/multi-worker:latest

docker push gavinxu838/multi-client:$SHA
docker push gavinxu838/multi-server:$SHA
docker push gavinxu838/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=gavinxu838/multi-client:$SHA
kubectl set image deployments/server-deployment server=gavinxu838/multi-server:$SHA
kubectl set image deployments/worker-deployment client=gavinxu838/multi-worker:$SHA
