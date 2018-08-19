GO=go
PROG=quade

all: generate test build

generate:
	$(GO) generate

build: generate
	$(GO) build -o $(PROG)

test: generate
	$(GO) test -v ./...

clean:
	rm -f parser/parser.go y.output
	$(GO) clean
