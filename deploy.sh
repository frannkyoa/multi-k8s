docker build -t frannkyoa/multi-client:latest -t frannkyoa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t frannkyoa/multi-server:latest -t frannkyoa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t frannkyoa/multi-worker:latest -t frannkyoa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push frannkyoa/multi-client:latest
docker push frannkyoa/multi-server:latest
docker push frannkyoa/multi-worker:latest

docker push frannkyoa/multi-client:$SHA
docker push frannkyoa/multi-server:$SHA
docker push frannkyoa/multi-worker:$SHA

kubectl apply -f /k8s
kubectl set image deployments/server-deployment server=frannkyoa/multi-server:$SHA
kubectl set image deployments/client-deployment client=frannkyoa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=frannkyoa/multi-worker:$SHA
