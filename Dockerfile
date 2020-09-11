# ------------------- gentoo as builder base
FROM ghcr.io/gentoo-docker-builds/gendev:latest as builder

# ------------------- emerge
RUN echo 'app-emulation/skopeo ~amd64' >> /etc/portage/package.accept_keywords
RUN emerge -C sandbox
RUN ROOT=/skopeo emerge app-emulation/skopeo

# ------------------- shrink

# ------------------- empty image
FROM scratch
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY --from=builder /skopeo /
COPY --from=builder /bin/sh /
