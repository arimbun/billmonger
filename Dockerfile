# --------------------------------------
# Build Stage
# --------------------------------------
FROM golang:1.10 as build_stage
RUN mkdir /app 
ENV GOPATH /go
ADD . /go/src/github.com/arimbun/billmonger
WORKDIR /go/src/github.com/arimbun/billmonger
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure
RUN go build

# --------------------------------------
# Production Container
# --------------------------------------
FROM scratch
COPY --from=build_stage /go/src/github.com/arimbun/billmonger/billmonger /
CMD [/billmonger]
