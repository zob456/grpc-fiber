FROM golang:1.17-alpine


COPY go.mod src/zobFiber/go.mod
COPY go.sum src/zobFiber/go.sum
COPY services/rest-api src/zobFiber/rest-api

WORKDIR /go/src/zobFiber/rest-api
RUN CGO_ENABLED=0 GOOS=linux GARCH=amd64 go build -installsuffix cgo -o build/rest-api .

CMD ["./build/rest-api"]
EXPOSE 8080