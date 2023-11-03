all: build/dashboard

build/dashboard: cmd/dashboard/*.go ui/*.go config.go
	mkdir -p build
	go build -race -o build/dashboard -v ./cmd/dashboard/
