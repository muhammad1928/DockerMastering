#### Building and Running a Basic Docker Container

## How to create build and run docker
Start by creating a new directory for Docker and navigate to it using

```bash
mkdir my-docker-project
cd my-docker-project
```

# Create a Docker file
The Dockerfile is where you’ll define the image configuration. Create a new file named

```bash
nano Dockerfile
```

Add the following content to the Dockerfile, Content includes comments to clearify.

```bash
# Use the official Nginx image as the base image
FROM nginx:latest

# Copy a custom index.html file to the default Nginx directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to allow external access
EXPOSE 80

```
The Dockerfile use the official Nginx image, copies a custom HTML file into the Nginx web directory, and exposes port 80 so that users can access the container from a web browser.


# HTML file
Now, create an HTML file. This file should be named index.html and located in the same directory as your Dockerfile.

```bash
nano index.html
```

Add some content to the html file. ex:

```bash
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Docker Nginx Server</title>
</head>
<body>
    <h1>Hello, Docker!</h1>
    <p>This is a simple web page served by an Nginx container.</p>
</body>
</html>
```
save and close the file. The Nginx will serve this html file.


# Build the Docker image
we will use the Dockerfile to build a Docker image. Run the following command
```bash
docker build -t my-nginx-image .
```

Here’s what each part of the command does:
- ```bash docker build``` docker build tells Docker to build an image.
- ```bash -t my-nginx-image``` assigns the name ```bash my-nginx-image``` to the image.
- ```bash .``` specifies the current directory as the build context (where Docker will look for the Dockerfile and any files to include in the image).

ps. Docker will go through the steps in the Dockerfile, downloading the base Nginx image if it’s not already available, and then copying the HTML file.

# Verify the Image
Once the image build is complete, you can check if it was created successfully by listing all Docker images:
```bash 
docker images
```
You should see *my-nginx-image* in the list.

# Run the Docker Container
Now that the image is built, you can create and run a container from it
```bash 
docker run -d -p 8080:80 --name my-nginx-container my-nginx-image
```
You will see these in the command:
- ```bash  docker run``` creates and starts a new container.
- ```bash  -d``` runs the container in detached mode (in the background).
- ```bash  -p 8080:80``` maps port 80 inside the container to port 8080 on your local machine, so you can access the Nginx server via ```bash  localhost:8080```.
- ```bash --name my-nginx-container``` names the container ```bash my-nginx-container```.
- ```bash my-nginx-image``` specifies the image to use.


# test the docker
To check if the container is running, list all running containers
```bash 
docker ps
```

You should see ```bash my-nginx-container``` in the list.
Open a web browser and go to ```bash http://localhost:8080```. You should see the content from your ```bash index.html``` file displayed. If you’re running this on a server, use the server’s IP address instead.


# Stop and Remove the Container
To stop the container, use the following command
```bash 
docker stop my-nginx-container
```
To remove the container after stopping it:
```bash 
docker rm my-nginx-container
```
To clean up the image
```bash 
docker rmi my-nginx-image
```
And that’s it! You’ve successfully created a Dockerfile, built a Docker image, ran it as a container, and verified it was working. This process gives you a solid foundation for understanding how Docker images and containers work. Let me know if you have any questions or need further details!




