# use alpine

FROM alpine:latest

# set Environment

ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=


# Create folders

RUN mkdir -p /install && mkdir /git

# Deploy tools 

RUN apk add --update-cache --virtual 'temp-utils' gcc make g++ libffi-dev openssl-dev zlib-dev curl unzip && \
        curl -L https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz -o /install/python.tgz && \
        tar xvf /install/python*.tgz -C /install/ && \
        cd /install/Python*/ && \
        ./configure --with-ensurepip=install && \
        make install && \
        pip3 install ansible && \
        apk add jq git

# Install permanent tools

#RUN apk add jq git




# Compile python 3 with pip and install Ansible
#RUN curl -L https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz -o /install/python.tgz && \
#        tar xvf /install/python*.tgz -C /install/ && \
#        cd /install/Python*/ && \
#        ./configure --with-ensurepip=install && \
#        make install && \
#        pip3 install ansible    

RUN curl -L https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip -o /install/terraform.zip && \
        unzip /install/terraform*.zip -d /usr/local/bin/ && \
        chmod +x /usr/local/bin/terraform 

# Perform the cleanup
RUN apk del 'temp-utils' && rm -rf /install

CMD ["sh"]