# Project 5
## Project Overview
## Part 1 - Dockerize it
I installed Docker Desktop for Mac with Intel chip.  
I built the container by using the command `docker build -t my-apache2 .`  
I ran the container by using the command `docker run -dit --name my-running-app -p 8080:80 my-apache2`
## Part 2 - GitHub Actions and DockerHub
Go to the `Repositories` tab and click `Create Repository`. Give it a name and make sure it's public, then click `Create`. I then created two action Secrets in GitHub in my respository called `DOCKER_USERNAME` and `DOCKER_PASSWORD` and put the repective information underneath. To login on the command line you can use `docker login -u 'your username' -p 'your password'`. Using a token is more secure than password but I didn't do that. On push, the build-push workflow logs in to docker using the secret credentials. Then it builds the image based on the Dockerfile and pushes the latest version to DockerHub. I had variables in my workflow for the secrects and for my environment which I made my docker repo.
## Part 3 - Deployment  
- install docker:
    - `sudo apt install docker.io`
## Part 4 - Diagramming