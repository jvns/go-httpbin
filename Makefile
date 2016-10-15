build: dist/go-httpbin

dist/go-httpbin: assets *.go httpbin/*.go
	mkdir -p dist
	go build -o dist/go-httpbin

assets: httpbin/templates/*.html
	go-bindata -o httpbin/templates.go -pkg=httpbin -prefix=httpbin/templates httpbin/templates

test:
	go test -v github.com/mccutchen/go-httpbin/httpbin

testcover:
	mkdir -p dist
	go test -coverprofile=dist/coverage.out github.com/mccutchen/go-httpbin/httpbin
	go tool cover -html=dist/coverage.out

run: build
	./dist/go-httpbin

clean:
	rm -r dist

deps:
	go get -u github.com/jteeuwen/go-bindata/...

.PHONY: all