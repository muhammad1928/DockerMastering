# Using Docker Compose for Multi-Container Applications

In this tutorial, you will learn how to define and manage a basic multi-container application using Docker Compose. We will set up a simple web application consisting of two services: a web server and a database. Docker Compose will manage the services, network, and volumes required.

## Step 1: Create the `docker-compose.yml` file

Create a file called `docker-compose.yml` in your project directory. This file defines the services, networks, and volumes for your multi-container application.

```yaml
version: '3'
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
  db:
    image: postgres:latest
    environment:
      POSTGRES_USER: exampleuser
      POSTGRES_PASSWORD: examplepass
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

## Step 2: Create HTML for the Web Service

In the same directory, create a folder named `html` and inside that, a file named `index.html`. This will be served by the web service.

```html
<!DOCTYPE html>
<html>
  <body>
    <h1>Welcome to Docker Compose</h1>
  </body>
</html>
```

## Step 3: Run the Docker Compose Application

Now, you can start your multi-container application by running the following command in your project directory:

```bash
docker-compose up
```

## Step 4: Verify the Web Application Locally

To verify that the web server is running and serving the `index.html` file, use the `curl` command to fetch the content from `localhost:8080`:

```bash
curl http://localhost:8080
```

This command should return the content of your `index.html` file, which looks like this:

```html
<!DOCTYPE html>
<html>
  <body>
    <h1>Welcome to Docker Compose</h1>
  </body>
</html>
```

If you see this output in the terminal, the web service is successfully running!
