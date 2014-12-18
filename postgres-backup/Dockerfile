FROM postgres
MAINTAINER Eugen Rochko <eugen@zeonfederated.com>

ADD backup.sh /backup.sh
RUN chmod +x /backup.sh

VOLUME /backup

CMD /backup.sh
