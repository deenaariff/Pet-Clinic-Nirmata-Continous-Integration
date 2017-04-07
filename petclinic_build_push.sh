echo "Enter DockerHub username:"
read username

docker-machine start default

eval $(docker-machine env)
mvn clean install -PbuildDocker
docker-compose down
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

docker push $username/spring-petclinic-api-gateway
docker push $username/spring-petclinic-discovery-server
docker push $username/spring-petclinic-config-server
docker push $username/spring-petclinic-visits-service
docker push $username/spring-petclinic-vets-service
docker push $username/spring-petclinic-customers-service
