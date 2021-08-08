FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install curl unzip git jq -y

# install node and yarn
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash -
RUN apt-get -y install nodejs
RUN npm install -g yarn

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install

RUN git clone https://github.com/mmuller88/cdk-prowler.git /cdk-prowler
RUN cd cdk-prowler && yarn add projen && npx projen

# RUN mkdir -p /etc/init.d
COPY commands.sh /etc/init.d/commands.sh
RUN chmod +x /etc/init.d/commands.sh
ENTRYPOINT ["/etc/init.d/commands.sh"]