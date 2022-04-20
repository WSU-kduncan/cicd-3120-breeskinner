#!/bin/sh

#stop old container
sudo docker stop mysite
#prune old images
sudo docker system prune -f -a
#pull new image
sudo docker pull breeskinner/ceg3120-project5:latest
#run new image
sudo docker run -d --name mysite --rm -p 80:80 breeskinner/ceg3120-project5:latest
