
# This is the Build stage

# Taking the base image 
FROM node:20-alpine AS build
#Setting up the Working directory inside the container
WORKDIR /Tarun
# Copying the Package.json file 
COPY Package.json /Tarun/
# Installing the dependencies form package.json
RUN npm ci
# Copiying the Complete sourec code on to docker image
COPY  . .
# Building the applicatio 
RUN nup run build 

# Production Stage
# taking the base image in the Productions stage
FROM nginix:alpine
# Copiying the Binary or the Artifacts from build stage to prodcution stage
COPY --from=build  /Tarun/dist /usr/share/nginix/htmldest
# Exposing the Port 80
EXPOSE 80

# Exicuting or starting the docker container as part of a CMD
CMD [ "nginix", "-g", "demon off:" ]
