# A configuration script that runs on the pi, common to all deployments.
# The input is a base ubuntu image, the output is an image suitable to be
# tweaked further (eg setting custom IDs)

touch /etc/cloud/cloud-init.disabled

adduser --disabled-password --gecos "Admin" --ingroup sudo --shell /bin/bash admin
echo "admin:${ADMIN_PASSWORD}" | chpasswd

# apt-get update
# apt-get upgrade -y


