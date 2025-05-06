# Use a basic web server image
FROM nginx:alpine

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy your site into the nginx web directory
COPY index.html /usr/share/nginx/html/

# Expose port (optional)
EXPOSE 80
