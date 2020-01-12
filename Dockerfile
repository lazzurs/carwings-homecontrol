FROM golang:latest

RUN useradd -ms /bin/bash carwings
RUN chown -R carwings.carwings /go

USER carwings
ENV PATH /go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /go/src/app
COPY . .

USER root
RUN chown -R carwings.carwings /go/src/app
RUN mkdir /etc/carwings-homecontrol
USER carwings

RUN go get -d -v ./...
RUN go install -v ./...

CMD ["/go/bin/carwings-homecontrol", "-config", "/etc/carwings-homecontrol/config.json"]