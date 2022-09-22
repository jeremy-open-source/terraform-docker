FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN     apt-get update \
    &&  apt-get install -y \
            apt-transport-https \
            ca-certificates \
            apt-utils \
            software-properties-common \
            openssh-client \
            gnupg \
            nano \
            curl \
            jq

# Install Terraform CLI
RUN     curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    &&  apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    &&  apt-get update \
    &&  apt-get install -y terraform \
    &&  terraform --version

# Install Dopper CLI
RUN     curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | apt-key add - \
    &&  echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list \
    &&  apt-get update \
    &&  apt-get install -y doppler \
    &&  doppler --version
