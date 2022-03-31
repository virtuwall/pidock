
FROM scratch

ADD root.tar /

ARG ADMIN_PASSWORD
RUN adduser --disabled-password --gecos "Admin" --ingroup sudo --shell /bin/bash admin
RUN echo "admin:${ADMIN_PASSWORD}" | chpasswd

USER admin

ARG SSH_PUB_KEY
RUN mkdir /home/admin/.ssh
RUN echo ${SSH_PUB_KEY} > /home/admin/.ssh/authorized_keys

ADD root-overlay /

RUN netplan try



# ADD configure/configure-common.sh /configure/configure-common.sh
# RUN /configure/configure-common.sh
