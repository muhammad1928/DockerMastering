#### Building and Running a Basic Docker Container

## Why Data Persistence is Important
Data persistence is crucial in applications for several reasons:

- Data Retention: It ensures that data is not lost when the application is restarted or the system is shut down.
- Data Sharing: Persistent data can be shared across multiple containers or instances of an application.
- Data Backup and Recovery: Persistent data can be backed up and restored in case of system failures or data corruption.
- Data Integration: It allows for integration with external data sources and systems.
## Docker Volumes
Docker volumes are a mechanism for persisting data outside of the container's file system. This means that even if the container is deleted or recreated, the data stored in the volume remains intact.

## Key features of Docker volumes:

- Mount points: Volumes are mounted as directories within the container's file system.
- Data persistence: Data stored in volumes is not deleted when the container is removed.
- Shared volumes: Volumes can be shared between multiple containers.
- Named volumes: Volumes can be given names for easier management.
- Data management: Volumes can be created, inspected, and removed using Docker commands.


## Creating and using a Docker volume:

# Create a volume
```bash
docker volume create my-data-volume
```

# Run a container with the volume mounted
```bash
docker run -v my-data-volume:/data my-image
```
This mounts the my-data-volume volume to the /data directory within the container.