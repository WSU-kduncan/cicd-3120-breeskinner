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
- install go:
    - `wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz`
- open tar file:
    - `sudo tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz`
- add go to PATH:
    - `export PATH=$PATH:/usr/local/go/bin`
- install webhook with github:
    - `go install github.com/adnanh/webhook@latest`
- restart script: restart.sh
``` 
    #!/bin/sh    
    #stop old container  
    sudo docker stop mysite  
    #prune old images  
    sudo docker system prune -f -a  
    #pull new image  
    sudo docker pull breeskinner/ceg3120-project5:latest  
    #run new image  
    sudo docker run -d --name mysite --rm -p 80:80 breeskinner/ceg3120-project5:latest  
 ``` 
Stops container mysite and then gets rid of all unused containers. Then pulls the latest version of mysite and runs it detatched on port 80.  
- webhook task definition file: redeploy.json
```
[
	{
		"id": "mysite",
		"execute-command": "/home/ubuntu/cicd-3120-breeskinner/restart.sh",
		"command-working-directory": "/home/ubuntu/cicd-3120-breeskinner"
	}
]
```
id is the name of which webhook it's using  
ececute-command is where the script that tells what commands to do (if that makes sense)  
command-working-directory is where the script is located  
- created a webhook on dockerhub:
    - named it deploy with this url: `http://52.202.140.117:9000/hooks/mysite`
- run the webhook:
    - `/home/ubuntu/go/bin/webhook -hooks redeploy.json --verbose`
## Part 4 - Diagramming  
```mermaid
graph TD;
    A[Changes are made locally to website files and pushed to GitHub]-->B{}
```