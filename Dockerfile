FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

RUN microdnf module enable python39:3.9 && microdnf -y install python39 git && microdnf clean all

RUN pip3 install python-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && python3 /tmp/s3cmd/setup.py install \
  && cd / \
  && rm -rf /tmp/s3cmd \
  && microdnf -y remove git perl-Git \
  && microdnf clean all

WORKDIR /s3

ENTRYPOINT ["s3cmd"]
CMD ["--help"]
