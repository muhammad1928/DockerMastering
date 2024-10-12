## Create Dockerfile
his Dockerfile will use the official Nginx image and set up a simple HTML page with "Hello, World!" content.

Start with creating and editing a dockerfile by typing
```bash
nano Dockerfile
```
Then type the following to the inside the nano
```bash
FROM alpine:latest
RUN apk add --no-cache python3
COPY index.html /index.html
CMD python3 -m http.server 80 --directory 
```
First save the file ``` CTRL + O``` and hit ```ENTER ```.
Afterwards, press ``` CTRL + X ``` to exit the nano
<!-- ```bash
echo -e "FROM alpine:latest\nRUN apk add --no-cache python3\nCOPY index.html /index.html\nCMD python3 -m http.server 80 --directory /" > Dockerfile
``` -->



<!-- - ```echo``` is a command used to display text or send it to a file
- ```-e```enables interpretation of special characters like ```\n``` for newlines, so each segment of the text will be on a new line in the file. -->
- ```FROM alpine:latest``` specifies the base image for the Docker container. This part is very popular choice, when creating a simple container
- ```RUN apk add --no-cache python3\n``` RUN is a docker instruction that runs commands in the shell inside the container. it uses alpine package to install python 3. ```--no-cache``` ensures that apk does not cache the index locally, which helps reduce the final image size. ```\n``` this starts a new line in the Dockerfile
- ```CMD python3 -m http.server 80 --directory /``` ```CMD``` specifies to run the command when container starts. ``python3 -m http.server 80`` runs Python’s built-in HTTP server on port 80, making it accessible from outside the container. 
<!-- - ``> Dockerfile:`` this command writes(overwrites) a file called Dockerfile. -->

The dockerfile created by this command line will look like this

````
FROM alpine:latest
RUN apk add --no-cache python3
COPY index.html /index.html
CMD python3 -m http.server 80 --directory /
```

## This Dockerfile:

1. Uses Alpine as the base image.
2. Installs Python 3.
3. Copies index.html into the root directory of the container.
4. Starts a simple HTTP server that serves files in the root directory, making the HTML file available when you access the container's exposed port.


click on the ```Check``` button to verify that everything is correctly executed