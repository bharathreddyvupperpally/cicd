# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy your HTML file to the Nginx web directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
