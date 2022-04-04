FROM jenkins/jenkins:lts

USER root

# install yarn
RUN apt install curl
RUN apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends nodejs npm \
    && npm install -g yarn

RUN apt update && apt -y upgrade \
    && apt install lsb-release ca-certificates apt-transport-https software-properties-common -y \
    && apt update && apt install -y wget gnupg2 lsb-release \
    && wget https://packages.sury.org/php/apt.gpg && apt-key add apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt update && apt install -y php8.0
# install PHP and Composer
RUN apt install -y composer php8.0-zip php8.0-mbstring php8.0-xml
#RUN apt install install php \
#    && apt install -y composer

# install aws-cdk
RUN npm install -g aws-cdk

USER jenkins
