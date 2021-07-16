SHELL:=/bin/sh
.PHONY: build clean fmt

export GO111MODULE=on

#path related
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
RELEASE_DIR := $(MKFILE_DIR)bin

# Version
RELEASE?=1.0.1

#Build flags
GO_LD_FLAGS= "-s -w"

#Targets
TARGET_TCP_SERVER=${RELEASE_DIR}/tcpserver

build: build_tcpserver

build_tcpserver:
		@echo "build tcp server"
		cd ${MKFILE_DIR} && \
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -trimpath -ldflags ${GO_LD_FLAGS} \
		-o ${TARGET_TCP_SERVER} ${MKFILE_DIR}cmd/tcpserver

build_tcpserver_docker:
		docker build -t wusir27/hellogo-tcpserver:${RELEASE} -f ./build/package/tcpserver/Dockerfile .

clean:
		rm -rf ${RELEASE_DIR}

fmt:
		cd ${MKFILE_DIR} && go fmt ./...