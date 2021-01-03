# use alpine

FROM alpine:latest

# set Environment

ENV AWS_SECRET=
ENV AWS_KEY=


# Deploy tools 

RUN apk add --update-cache \
            gcc \
            make \
            g++ \ 
            libffi-dev \
            openssl-dev \
            zlib-dev \
            curl \
            unzip \
	    jq

RUN mkdir -p /install && mkdir /git

RUN curl -L https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz -o /install/python.tgz && \
        tar xvf /install/python*.tgz -C /install/ && \
        cd /install/Python*/ && \
        ./configure --with-ensurepip=install && \
        make install && \
        pip3 install ansible
        

RUN curl -L https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip -o /install/terraform.zip && \
        unzip /install/terraform*.zip -d /usr/local/bin/ && \
        chmod +x /usr/local/bin/terraform 

RUN apk del curl gcc make g++ libffi-dev openssl-dev zlib-dev unzip && rm -rf /install

CMD ["sh"]
