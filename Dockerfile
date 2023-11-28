FROM openjdk:8
FROM node:14

EXPOSE 8080
ADD target/kubernetes.jar kubernetes.jar
ENTRYPOINT ["java","-jar","/kubernetes.jar"]



# Set the working directory inside the container
WORKDIR /app

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
