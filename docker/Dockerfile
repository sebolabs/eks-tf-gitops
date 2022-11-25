FROM amazonlinux:2

RUN yum install -y wget unzip util-linux-ng epel-release nmap tree python-pip git-core which jq
RUN pip install --upgrade pip awscli

RUN git clone https://github.com/tfutils/tfenv.git /.tfenv \
      && ln -s /.tfenv/bin/* /usr/local/bin

ADD ./services /opt
