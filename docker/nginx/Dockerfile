FROM nginx

# Copy custom configuration file from the current directory
COPY default.conf /etc/nginx/conf.d/default.conf

# Append "daemon off;" to the beginning of the configuration
# in order to avoid an exit of the container
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Define default command
CMD service nginx start
