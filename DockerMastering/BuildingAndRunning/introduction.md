#### Building and Running a Basic Docker Container

## How to create build and run docker Step 1.

Start by creating a new directory for Docker container and navigate to the folder using terminal.
```bash
mkdir my-docker-project
cd my-docker-project
```

`mkdir my-docker-project` creates the folder
`cd my-docker-project` navigates in to the folder


## Step 2. Create a Docker file

You will start by editing a dockerfile by using `nano Dockerfile` in the terminal. 
```bash
nano Dockerfile
```
This command serves as entering into a docker file named Dockerfile. It allows you to edit the dockerfile.
This Dockerfile is where you will define the image configurations.

Add the following content to the terminal.

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```
After this press `CTRL + O and ENTER` to save the dockerfile and `CTRL + X` to exit the dockerfile.

The Dockerfile use the official Nginx image, copies a custom HTML file into the Nginx web directory, and exposes port 80 so that users can access the container from a web browser.


## Step 3. Create HTML file

Now, create an HTML file. This file should be named index.html and located in the same directory as your Dockerfile.

```bash
nano index.html
```

Add some content to the html file:

```html
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
After this press `CTRL + O and ENTER` to save the index.html file and `CTRL + X` to exit the html file.
The Nginx will serve this html file.


## Step 4. Build the Docker image

We will use the Dockerfile to build a Docker image. Run the following command
```bash
docker build -t my-nginx-image .
```

Here’s what each part of the command does:
- `docker build` docker build tells Docker to build an image.
- `-t my-nginx-image` assigns the name `my-nginx-image` to the image.
- `.` specifies the current directory as the build context (where Docker will look for the Dockerfile and any files to include in the image).

ps. Docker will go through the steps in the Dockerfile, downloading the base Nginx image if it’s not already available, and then copying the HTML file.


## Step 5. Verify the Image

Once the image build is complete, you can check if it was created successfully by listing all Docker images:
```bash 
docker images
```
You should see *my-nginx-image* in the list.


## Step 6. Run the Docker Container

Now that the image is built, you can create and run a container from it
```bash 
docker run -d -p 8080:80 --name my-nginx-container my-nginx-image
```
You will see these in the command:
- 
`docker run`
 creates and starts a new container.
- 
`-d`
 runs the container in detached mode (in the background).
- 
`-p 8080:80`
 maps port 80 inside the container to port 8080 on your local machine, so you can access the Nginx server via localhost:8080
.
- 
`--name my-nginx-container`
 names the container 
`my-nginx-container`
.
- 
`my-nginx-image`
 specifies the image to use.


## Step 7. Test the docker
To check if the container is running, list all running containers
```bash 
docker ps
```

You should see your docker container.
