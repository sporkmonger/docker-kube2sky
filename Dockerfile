FROM quay.io/sporkmonger/go
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN apk add --update bind-tools && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/bin

COPY ./start /opt/bin/start
RUN chmod a+x /opt/bin/start

RUN go get github.com/GoogleCloudPlatform/kubernetes/cluster/addons/dns/kube2sky && \
  cd /go/src/github.com/GoogleCloudPlatform/kubernetes/cluster/addons/dns/kube2sky && \
  make kube2sky && \
  cd - \
  mv /go/src/github.com/GoogleCloudPlatform/kubernetes/cluster/addons/dns/kube2sky/kube2sky /opt/bin/kube2sky

# Run the boot script
ENTRYPOINT /opt/bin/start
