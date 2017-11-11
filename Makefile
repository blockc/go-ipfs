# General tools

SHELL=PATH='$(PATH)' /bin/sh

PROTOC = protoc --gogo_out=. --proto_path=.:/usr/local/opt/protobuf/include:$(dir $@) $<

# enable second expansion
.SECONDEXPANSION:

include Rules.mk

dev:
	docker run --rm \
	 --name ipfs-building \
	 -v `pwd`:/opt/gopath/src/github.com/ipfs/go-ipfs \
	 -w /opt/gopath/src/github.com/ipfs/go-ipfs \
	 ckeyer/dev:ipfs bash

image:
	docker run --rm \
	 --name ipfs-building \
	 -v `pwd`:/opt/gopath/src/github.com/ipfs/go-ipfs \
	 -w /opt/gopath/src/github.com/ipfs/go-ipfs \
	 ckeyer/dev:ipfs make local
	docker build -t ckeyer/ipfs .

local:
	cp ${GOPATH}/bin/* bin/
	make build
