if [ -z "$1" ] ; then
    echo "usage: $0 IMG_FILE MOUNT_POINT PARTITION_NUMBER"
    exit 1
fi
IMG_FILE=$1

if [ -z "$2" ] ; then
    echo "usage: $0 IMG_FILE MOUNT_POINT PARTITION_NUMBER"
    exit 1
fi
MOUNT_POINT=$2

if [ -z "$3" ] ; then
    echo "usage: $0 IMG_FILE MOUNT_POINT PARTITION_NUMBER"
    exit 1
fi
PARTITION_NUMBER=$3

echo "Mounting partition ${PARTITION_NUMBER} of ${IMG_FILE} at ${MOUNT_POINT}"

START=$(fdisk -l -o Start ${IMG_FILE} | tail -n +9 | head -n${PARTITION_NUMBER} | tail -n1)
OFFSET=$(expr ${START} \* 512)
mount -o loop,offset=${OFFSET} ${IMG_FILE} ${MOUNT_POINT}

echo "Use 'umount ${MOUNT_POINT}' to unmount"
