FROM debian:buster-slim
WORKDIR /
COPY sdet-service .
CMD ["./sdet-service"]