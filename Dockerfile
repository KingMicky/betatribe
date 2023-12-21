FROM openjdk:8
FROM node:14

EXPOSE 8080
ADD target/kubernetes.jar kubernetes.jar
ENTRYPOINT ["java","-jar","/kubernetes.jar"]

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose a port that the application will listen on
EXPOSE 3000

# Define the command to run when the container starts
CMD [ "npm", "start" ]

docker build -t kubernetes .

# Run the image
docker run -p 3000:3000 kubernetes

# Push the image to Docker Hub
docker push kubernetes

# Create a deployment
kubectl create deployment kubernetes --image=kubernetes

# Expose the deployment
kubectl expose deployment kubernetes --type=LoadBalancer --port=8080

# Scale the deployment
kubectl scale deployment kubernetes --replicas=3

# Update the image
kubectl set image deployment/kubernetes kubernetes=kubernetes:2.0


