BINARY_NAME=go-app

all: build lint test

build:
	@echo "Building binary..."
	go build -o bin/$(BINARY_NAME) main.go

run:
	go run main.go

test:
	go test -v -race ./...

lint:
	golangci-lint run

clean:
	rm -rf bin/

docker-build:
	docker build -t $(BINARY_NAME):latest .

.PHONY: all build run test lint clean docker-build
