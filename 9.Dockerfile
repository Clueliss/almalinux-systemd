FROM almalinux:9

ENV container=docker

RUN cd /lib/systemd/system/sysinit.target.wants \
    && for f in *; do \
        if [ $f != systemd-tmpfiles-setup.service ]; then \
            rm -f $f; \
        fi \
    done

RUN rm -f \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/{\
        multi-user.target.wants/*,\
        local-fs.target.wants/*,\
        sockets.target.wants/*udev*,\
        sockets.target.wants/*initctl*,\
        system/basic.target.wants/*,\
        anaconda.target.wants/*\
    }

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["/usr/sbin/init"]
