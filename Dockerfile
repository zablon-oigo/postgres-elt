FROM duckdb/duckdb:latest

WORKDIR /data

ENTRYPOINT ["duckdb"]
CMD ["dev.duckdb"]