# docker-workflow 1.15.1 can not handle this. See:
# https://issues.jenkins-ci.org/browse/JENKINS-46105
#ARG  BASE_TAG=7-stackbase-devtoolset-6
#FROM lsstsqre/centos:${BASE_TAG}
ARG BASE_IMAGE=lsstdm/scipipe-base:7
FROM $BASE_IMAGE

ARG LSST_SPLENV_REF
ARG LSST_PYTHON_VERSION=3
ARG NEW_DIR=/opt/lsst/software/stack
ARG LSST_USER=lsst
ARG NEWINSTALL_URL=https://raw.githubusercontent.com/lsst/lsst/master/scripts/newinstall.sh
ARG LSST_EUPS_PKGROOT_BASE_URL=https://eups.lsst.codes/stack

USER root

RUN mkdir -p "$NEW_DIR"
RUN groupadd "$LSST_USER"
RUN useradd -g "$LSST_USER" -m "$LSST_USER"
RUN chown "${LSST_USER}:${LSST_USER}" "$NEW_DIR"

USER $LSST_USER
WORKDIR $NEW_DIR

SHELL ["/bin/bash", "-o", "pipefail", "-lc"]
RUN curl -sSL "$NEWINSTALL_URL" | bash -s -- -cbtS

SHELL ["/bin/bash", "-lc"]
