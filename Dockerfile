# Stage 1: Base Stage (3.a)
FROM ubuntu:22.04 AS base

# Install cron and other necessary utilities
RUN apt-get update && \
    apt-get install -y cron sudo && \
    apt-get clean

# Create the 'abc' user and set up the directory with specific permissions
RUN useradd -m abc && \
    mkdir -p /home/abc/specific_folder && \
    chown -R abc:abc /home/abc/specific_folder

# Set the working directory
WORKDIR /home/abc

# Stage 2: Intermediate Stage (3.b)
FROM base AS intermediate

# Switch to root user for copying files and setting permissions
USER root

# Copy the shell script to the container
COPY ./manage_folder.sh /home/abc/

# Make the shell script executable
RUN chmod +x /home/abc/manage_folder.sh

# Set up a cron job for the script to run (this runs as the 'abc' user)
RUN (echo "*/5 * * * * /home/abc/manage_folder.sh 0") | crontab -u abc -

# Stage 3: Clean-up Stage (3.c)
FROM intermediate AS cleanup

# Run the cron job with input '0' as the 'abc' user (delete folders)
USER abc
RUN echo "Running cleanup script" && /home/abc/manage_folder.sh 0

# Stage 4: Create Stage (3.d)
FROM intermediate AS create

# Run the cron job with input '1' as the 'abc' user (create folders and files)
USER abc
RUN echo "Running create script" && /home/abc/manage_folder.sh 1

# Final Stage (Optional) - If you want to run a server or additional tasks
# Uncomment the following if you wish to include any final service, such as starting Tomcat
# FROM tomcat:9.0.97
# COPY --from=create /home/abc/specific_folder /usr/local/tomcat/webapps/specific_folder
# EXPOSE 8080
# CMD ["sh", "/usr/local/tomcat/bin/catalina.sh", "run"]

