## Setting up Docker Volumes for Persistent Storage

Setting up Docker volumes is essential for ensuring that your data is stored persistently and not lost when a container is stopped or removed. 

Why Persistent Storage is Important
By default, when a container is deleted, all its data is lost because container storage is ephemeral (temporary). This behavior is fine for stateless applications, but for applications like databases or services that generate important data, you need a way to persist data beyond the life of the container. Docker volumes provide this persistence by allowing you to store data outside the container on the host system.

Here’s a step-by-step guide on creating and using Docker volumes to manage persistent storage.


## 1. Create a Docker Volume

Use the ```docker volume create``` command to create a new volume. Let’s call it ``` my_data_volume```
```bash 
docker volume create my_data_volume
```

Check if the volume was created successfully by listing all volumes
```bash 
docker volume ls
```
You will see the new volume ```bash my_data_volume``` in the list.


## 2. Create a Simple Container Using the Volume

In this example, we’ll use the official Nginx image and mount the volume to persist web server data.
Run a container that uses the volume
```bash 
docker run -d --name my_nginx -p 8080:80 -v my_data_volume:/usr/share/nginx/html nginx
```

### This is what each option does in the command:

``` -d ``` runs the container in detached mode.

``` --name my_nginx``` give names to the container ``` my_nginx```.

``` -p 8080:80``` maps port 80 on the container to port 8080 on your local machine.

``` -v my_data_volume:/usr/share/nginx/html``` mounts the ``` my_data_volume``` volume to the container’s web server directory ``` (/usr/share/nginx/html)```, where Nginx serves HTML files. This ensures that any files in this directory are stored on the host in the volume and persist beyond the container’s lifecycle.


## 3. Add Data to the Volume

You can add a file to the volume by copying this directly into the running container. 
```bash 
docker exec -it my_nginx /bin/bash
```

You’re now inside the container. Navigate to the volume’s directory and create a file
```bash 
echo "<h1>Hello from the persistent volume!</h1>" > /usr/share/nginx/html/index.html
```

Exit the container shell by typing 
```bash 
exit
```


## 4. Verify the Data Persistence
Access the container’s Nginx server from a browser by visiting ``` http://localhost:8080```. You should see the HTML content you just added.

Now, stop and remove the container
```bash 
docker stop my_nginx
docker rm my_nginx
```

Run a new container with the same volume mounted
```bash 
docker run -d --name new_nginx -p 8080:80 -v my_data_volume:/usr/share/nginx/html nginx
```
Check ``` http://localhost:8080``` again. You’ll see the same HTML content, proving that the data persisted even after the original container was removed.


## 5. Remove the Volume 
If you no longer need the volume and want to free up space, remove the volume with (make sure that the volume is not in use by any other containers, otherwise the code will fail): 
```bash 
docker volume rm my_data_volume
```

## Why Use Docker Volumes?

- Data Persistence: Volumes ensure that important data outlives containers, making them ideal for applications that generate data, like databases and CMSs.
- Container Sharing: Volumes allow you to share data between multiple containers, enabling a seamless flow of information. For example, you might have a web server and a database container both accessing the same data volume.
- Backup and Restore: Docker volumes can easily be backed up and restored, making data management more straightforward than with bind mounts or temporary container storage.
- Performance: Volumes can be more efficient on storage, especially with large datasets, as they are managed outside the container’s file system.



## Docker Volumes mechanism

Docker volumes are a mechanism for persisting data outside of the container's file system. This means that even if the container is deleted or recreated, the data stored in the volume remains intact.


## Key features of Docker volumes:

- Mount points: Volumes are mounted as directories within the container's file system.
- Data persistence: Data stored in volumes is not deleted when the container is removed.
- Shared volumes: Volumes can be shared between multiple containers.
- Named volumes: Volumes can be given names for easier management.
- Data management: Volumes can be created, inspected, and removed using Docker commands.


