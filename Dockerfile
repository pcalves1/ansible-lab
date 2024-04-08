FROM ubuntu:23.10
ARG ANSIBLE_PASSWORD

RUN apt-get update && apt-get install -y sudo openssh-server && \
    echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -m ansible && \
    echo "ansible:${ANSIBLE_PASSWORD}" | chpasswd

CMD ["/usr/sbin/sshd", "-D"]