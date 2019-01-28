# Use Alpine as base
FROM alpine:3.7
#FROM mongo:3.2.1

# LABEL Maintainer
LABEL maintainer="andreas@aquasec.com andreas.lambrecht@aquasec.com"

# Install curl
RUN apk --no-cache add py-pip libpq python-dev curl

# Install curl, python and pip + upgrade pip 
RUN apk --no-cache add py-pip libpq python-dev curl && \
    apk --no-cache add py2-pip && \
    pip install --upgrade pip

# Install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/
COPY images/*.* /usr/src/app/templates/images/

# Expose the app on Flask default (5000)
EXPOSE 5000

# HEALTHCHECK
HEALTHCHECK CMD curl --fail http://localhost:5000 || exit 1

# Run the application
CMD ["python", "/usr/src/app/app.py"]

# Scan the image with Aqua Micro Scanner
# RUN apt-get update && apt-get -y install ca-certificates
# ADD https://get.aquasec.com/microscanner .
# RUN chmod +x microscanner
# RUN ./microscanner NWViNGYyZjJiOWFj --html > amc-output.html && rm -rf /microscanner

# RUN apk add --update wget && apk add --no-cache ca-certificates && # update-ca-certificates && \
#     wget -O /microscanner https://get.aquasec.com/microscanner && \
#     chmod +x /microscanner && \
#     /microscanner NWViNGYyZjJiOWFj --html > amc-output.html && \
#     rm -rf /microscanner
