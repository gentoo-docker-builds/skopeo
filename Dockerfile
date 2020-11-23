# ------------------- gentoo as builder base
FROM ghcr.io/gentoo-docker-builds/gendev:latest as builder

# ------------------- emerge
RUN emerge -C sandbox
COPY portage/skopeo.accept_keywords /etc/portage/package.accept_keywords/skopeo
RUN ROOT=/skopeo emerge app-emulation/skopeo

# ------------------- shrink

# ------------------- alpine
FROM alpine:latest
COPY --from=builder /skopeo /
