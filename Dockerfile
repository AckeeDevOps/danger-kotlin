FROM node:12.18.1-buster

RUN apt-get update && apt-get install -y \
    curl \
    git \
    libncurses5 \
    openjdk-11-jre-headless

RUN cd /usr/local/bin && curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.34.2/ktlint && chmod +x ktlint

RUN npm install -g danger@10.2.1
# if we want to force step to build danger-kotlin we need to change following property
ARG dummy_version=1
RUN curl -s https://raw.githubusercontent.com/danger/kotlin/master/scripts/install.sh?dummy=$dummy_version | bash && \
    rm -r /root/.gradle

ENV PATH=$PATH:/usr/local/kotlinc/bin:/opt/gradle/gradle-5.6.2/bin

VOLUME /root/.gradle
