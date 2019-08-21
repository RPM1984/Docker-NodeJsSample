# Start from linux node image
FROM node:8-alpine

# Expose NodeJS port
EXPOSE 3000

# Add 'tini' (tiny 'init' for containers)
RUN apk add --update tini \
    && mkdir -p /usr/src/app

# Set directory in container
WORKDIR /usr/src/app

# Copy package.json into container
COPY package.json package.json

# Install packages
RUN npm install \
    && npm cache clean --force

# Now we can copy our copy in.
COPY . .

# Start node via tini
CMD ["/sbin/tini", "--", "node", "./bin/www"]