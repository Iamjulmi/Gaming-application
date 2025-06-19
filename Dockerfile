
# This is the Build stage

# Taking the base image 
FROM node:20-alpine AS build
#Setting up the Working directory inside the container
WORKDIR /app
# Copying the Package.json file 
COPY package*.json ./
# Installing the dependencies form package.json
RUN npm ci
# Copiying the Complete sourec code on to docker image
COPY  . .
# Building the applicatio 
RUN npm run build 

# Production Stage
# taking the base image in the Productions stage
FROM nginx:alpine

# Copiying the Binary or the Artifacts from build stage to prodcution stage
COPY --from=build /app/dist /usr/share/nginx/html
# Exposing the Port 80
EXPOSE 80

# Exicuting or starting the docker container as part of a CMD
CMD [ "nginx", "-g", "daemon off;" ]
