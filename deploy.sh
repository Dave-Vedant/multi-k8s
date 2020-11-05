docker build -t vedantdave77/docker-client:latest -t vedantdave77/docker-client:$SHA -f ./client/Dockerfile ./client   # This will build docker, tag latest SHA and copy docker file to buid folder
docker build -t vedantdave77/docker-server:latest -t vedantdave77/docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t vedantdave77/docker-worker:latest -t vedantdave77/docker-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vedantdave77/docker-client:latest
docker push vedantdave77/docker-server:latest
docker push vedantdave77/docker-worker:latest

docker push vedantdave77/docker-client:$SHA
docker push vedantdave77/docker-server:$SHA
docker push vedantdave77/docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=vedantdave77/docker-server:$SHA
kubectl set image deployment/client-deployment client=vedantdave77/docker-client:$SHA
kubectl set image deployment/worker-deployment worker=vedantdave77/docker-worker:$SHA