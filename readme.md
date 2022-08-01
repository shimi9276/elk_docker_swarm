

# Deploy an ELK stack to Docker swarm 

This specific guide is macOS M1 based. 

### Create the swarm 

1. Install UTM from [here](https://mac.getutm.app/)
2. Download Ubuntu server for [**ARM**](https://ubuntu.com/download/server/arm)
3. Create several virtual machines as you wish, using the above image.
Allocate 8 gigabytes per machine as elastic is memory intensive.
4. Set the network mode to bridged. The other settings can be left at default. Remember to eject the the ISO installer before rebooting
5. SSH into each created machine and run `git clone https://github.com/shimi9276/elk_docker_swarm.git && cd  elk_docker_swarm/`
6. run `./basic_installer.sh`
7. Exit and reconnect for the changes to be set

### Create the swarm

1. In the swarm-manager machine run `docker swarm init`. The output should include a join command with a token. Copy the command and paste in the other machines. Note you may need to add `sudo` to the command.
2. Run `docker node ls` and verify all the workers have been added.
3. Run `./ingress`. This script resets the default ingress network (this is done as a result of a bug, see [here](https://github.com/deviantony/docker-elk/issues/455]))

### Deploy the stack

1. In the swarm-manager machine, set the `.env` file variables according to your pleasing, then run `export $(cat .env | xargs)`. Note that the replica variable should eqaul the amount of workers in the swarm cluster
2. run `docker stack deploy -c <(docker-compose config) $DEPLOYMENT_NAME`. Note that if may take some time for the stack to be up and running as it may need to download the images, give it a few minutes.
3. Run `docker service ls` to see the stack status.
4. Get the IP of one of the workers and head to port 5601

You should now be able to see Kibana and your logs!