FROM scratch as shared

COPY / /

FROM quay.io/fedora/fedora-iot:44

RUN --mount=type=bind,from=shared,src=/,dst=/shared \
    dnf install -y $(jq -r .packages[] /shared/packages.json) && \
    dnf clean all && \
    rm -rf /var/cache/libdnf5 /var/lib/dnf/* /var/log/dnf5.log && \
    rm -rf /run/dnf /run/rpcbind /run/tuned

RUN bootc container lint --no-truncate
