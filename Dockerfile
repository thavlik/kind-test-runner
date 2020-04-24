FROM docker:dind

ENV KIND=v0.7.0
ENV KUBECTL=v1.17.0
ENV HELM=v3.1.2

RUN apk add --no-cache \
    wget \
    bash \
    tar

# Install kind
RUN wget -O /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/${KIND}/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind

# Install kubectl
RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && mkdir /root/.kube

# Install helm
RUN cd /tmp \
    && wget -O ./helm-${HELM}-linux-amd64.tar.gz https://get.helm.sh/helm-${HELM}-linux-amd64.tar.gz \
    && tar -xzvf ./helm-${HELM}-linux-amd64.tar.gz \
    && chmod +x linux-amd64/helm \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf /tmp \
    && mkdir /tmp \
    && helm version

WORKDIR /

COPY scripts /usr/local/bin
COPY manifest manifest

CMD ["time", "entrypoint"]
