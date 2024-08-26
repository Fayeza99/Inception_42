FROM debian:buster

# Update package list and upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install MariaDB server
RUN apt-get install -y mariadb-server

# Copy the custom configuration script into the container
COPY mariadb.sh /configure-mariadb.sh

# Make the script executable
RUN chmod +x /configure-mariadb.sh

# Run the script as the entrypoint
ENTRYPOINT [ "/configure-mariadb.sh" ]

# RUN docker run -d \
#   --name my-mariadb-container \
#   -e MYSQL_ROOT_PASSWORD=my-root-password \
#   -e MYSQL_DB=my-database \
#   -e MYSQL_USER=my-user \
#   -e MYSQL_PASSWORD=my-password \
#   -p 3306:3306 \
#   my-mariadb-image
