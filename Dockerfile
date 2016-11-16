# I decided to use Alpine linux for this image due to small image size
FROM alpine:3.4
MAINTAINER Ivan Gaas <ivan.gaas@gmail.com>

# I need git package to work with it
RUN apk -q --no-progress add --update git openssh-client && \
# Directory /code must be exists always for possible mount to a node
    mkdir -p /code 

# Then I need init script which will do all work
COPY init /

# Init script must run always
ENTRYPOINT ["/init"]
