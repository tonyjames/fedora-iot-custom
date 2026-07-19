FROM scratch as shared

COPY / /

FROM quay.io/fedora/fedora-iot:44

RUN --mount=type=bind,from=shared,src=/,dst=/shared \
    dnf install -y $(jq -r .packages[] /shared/packages.json) && \
    dnf clean all && \
    rm -rf /var/lib/dnf/* /var/log/dnf5.log 

RUN bootc container lint --no-truncate
