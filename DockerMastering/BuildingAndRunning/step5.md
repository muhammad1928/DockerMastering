## Run the Docker Container
Now, create and run a container from your newly built image.

```bash
docker run -d -p 8080:80 --name hello-world-container hello-world-image
```

- ```  docker run``` creates and starts a new container.
- ```-d``` runs the container in detached mode (in the background).
- ```-p 8080:80``` maps port 80 inside the container to port 8080 on your local machine,so you can access the server via ``` localhost:8080```.
- ``` --name hello-world-container``` names the container ``` hello-world-image```.
- ``` hello-world-image``` specifies the image to use.



click on the ```Check``` button to verify that everything is correctly executed