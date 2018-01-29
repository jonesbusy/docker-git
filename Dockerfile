# Base image to build git
FROM alpine:3.6 as builder

# Build arguments
ARG GIT_VERSION=2.16.1
ARG http_proxy=

# Compilation environment
ENV LIBRARY_PATH="/lib:/usr/lib" MAKEFILE_ARGS="NO_GETTEXT=1 NO_SYS_POLL_H=1 NO_TCLTK=1"

# Configure user and add some tools
RUN apk add --no-cache --virtual .build-deps ca-certificates build-base openssh-client openssl gnupg autoconf zlib-dev python-dev wget && \
	update-ca-certificates && \
	wget --quiet https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz && \
	tar xf v${GIT_VERSION}.tar.gz && \
	cd git-${GIT_VERSION} && \
	make configure &&  ./configure --prefix=/usr && make ${MAKEFILE_ARGS} && \
	make install ${MAKEFILE_ARGS} NO_GETTEXT=1 NO_SYS_POLL_H=1 NO_TCLTK=1 && \
	apk del .build-deps
	

# Run stage
FROM alpine:3.6
COPY --from=builder /usr/bin/git /usr/bin/git
ADD files/entrypoint.sh /entrypoint.sh

RUN apk add --no-cache ca-certificates openssl openssh-client su-exec && mkdir /git

# Entrypoint
WORKDIR /git

ENTRYPOINT ["/entrypoint.sh"]
