## Run the Container on the Custom Network

Now, run the ```hello-world-container``` on the ```hello-world-network``` network you just created.
For that, type:
```bash
docker run -d -p 8080:80 --name hello-world-container --network hello-world-network hello-world-image
```

#### Explanation:

- ```--network hello-world-network``` attaches the container to the custom network you created.
- All other parts of the command remain the same as before.


click on the ```Check``` button to verify that everything is correctly executed