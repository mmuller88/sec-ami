FROM node:12

RUN apt update -y && apt install jq -y

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install

RUN git clone https://github.com/mmuller88/cdk-prowler.git
RUN cd cdk-prowler && yarn add projen && npx projen

# RUN mkdir -p /etc/init.d
COPY commands.sh /etc/init.d/commands.sh
RUN chmod +x /etc/init.d/commands.sh
ENTRYPOINT ["/etc/init.d/commands.sh"]