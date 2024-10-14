## Configuring Container Networking
Configuring container networking allows containers to communicate with each other, share services, and connect to external networks. This is particularly useful for multi-container applications where different services (like a web server and a database) need to interact. Let’s go through how to set up a simple Docker network and connect containers to it.


## Step 1. To create a User-Defined Bridge Network

Docker provides several types of networks, but the bridge network is the default for isolated container environments. Let’s create a custom bridge network called `my-bridge-network`:
```bash 
clear
docker network create my-bridge-network
```
You can list available networks to verify that it was created
```bash 
docker network ls
```
You should see `my-bridge-network` in the list.


## Step 2. To run Containers on the Same Network

Let’s create two containers that we want to communicate over the network. We’ll use a web server container and a database container to illustrate this:

Run an Nginx web server container connected to `my-bridge-network`.:
```bash 
docker run -d --name web-server --network my-bridge-network nginx
```
Now, let’s create a Redis database container connected to the same network:
```bash 
docker run -d --name redis_db --network my-bridge-network redis
```


## Step 3. To verify Container Networking

You can now check that both containers are connected to `my-bridge-network`
```bash 
docker network inspect my-bridge-network   
```
In the output, you should see both `web-server` and `redis_db` listed as attached containers.


## Step 4. To test Communication Between Containers

Let’s check if the web server container can reach the Redis container. Use the `docker exec` command to access the `web-server` container and ping the.

First we need to install some utils like "ping"
```bash
docker exec -it web-server apt-get update
docker exec -it web-server apt-get install iputils-ping
```

You have to press **y** when installation is being processed. afterwards we can start pinging the db by:
`redis_db`:
```bash 
docker exec -it web-server ping redis_db
```
If the network configuration is correct, you should see ping responses from `redis_db`, indicating that the two containers can communicate.

Press `CTRL + C` to stop the ping. and click on `Check` to continue

### Use Container Hostnames in Applications

Docker assigns hostnames to containers based on their names in a user-defined bridge network. You can use these hostnames directly within applications.

For example, if your application in `web-server` container needs to connect to the Redis database, it can simply use `redis_db` as the hostname, rather than an IP address. This makes your application code more readable and portable.


## Step 5. To run Another Container on the Network 

You can add more containers to the network easily by specifying `--network my-bridge-network` in the `docker run` command.

For example, you could add a container that uses a different image, but still communicate with both `web-server` and `redis_db`
```bash 
docker run -d --name app-server --network my-bridge-network alpine
```


## Step 6. Clean Up the Network

Once you’re done, you can remove the containers and the network
```bash
docker rm -f web-server redis_db app-server
docker network rm my-bridge-network
```



## Why is Container Networking Important?
- Container networking allows multiple containers to communicate, enabling complex, multi-tier applications to function. By defining how containers connect to each other and to external networks, you can:
- Isolate services: Restrict container communication to certain containers, improving security.
- Simplify setup: By configuring a network once, you make it easier to launch containers that automatically join the network and communicate without extra configuration.
- Manage connectivity: Allow containers to connect to each other within a specific network for seamless data exchange.
- Control traffic: Define rules for incoming and outgoing connections, which is helpful for network policies in enterprise environments.

## Benefits of Using Docker Networks
- Enhanced Security: By isolating applications on their own networks, you can prevent unauthorized access and limit which containers can communicate with each other.
- Simplified Scaling: When you add new containers, they can automatically join the network and start communicating without additional configuration.
- Reduced Dependency on IP Addresses: Containers can refer to each other by name instead of IP, which makes managing applications easier, especially if containers are frequently started and stopped.
- Easier Multi-Container Applications: Networks facilitate smooth communication for multi-container setups, such as using a web server, application server, and database in the same environment.


Container networking is an essential aspect of building scalable, efficient applications in Docker, especially for complex setups where multiple services are involved. 