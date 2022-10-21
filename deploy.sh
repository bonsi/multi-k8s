docker build -t bonsi/multi-client:latest -t bonsi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bonsi/multi-server:latest -t bonsi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bonsi/multi-worker:latest -t bonsi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bonsi/multi-client:latest
docker push bonsi/multi-client:$SHA
docker push bonsi/multi-server:latest
docker push bonsi/multi-server:$SHA
docker push bonsi/multi-worker:latest
docker push bonsi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bonsi/multi-client:$SHA
kubectl set image deployments/server-deployment server=bonsi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bonsi/multi-worker:$SHA