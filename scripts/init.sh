#!/bin/bash

set -e

TAG="dataset-v1"
REPO="lukebarousse/dbt_Analytics_Engineering_Course"
BASE="https://github.com/${REPO}/releases/download/${TAG}"

DATA_DIR="data/raw"

mkdir -p "$DATA_DIR"

MONTHS=(
    2025-07 2025-08 2025-09 2025-10
    2025-11 2025-12 2026-01 2026-02
    2026-03 2026-04 2026-05 2026-06
)

for month in "${MONTHS[@]}"; do

    filename="raw_job_postings_${month}.parquet"

    echo "Downloading $filename ..."

    wget -nc "$BASE/$filename" -P "$DATA_DIR"

done

echo "Downloading raw_job_skills.parquet ..."

wget -nc "$BASE/raw_job_skills.parquet" -P "$DATA_DIR"

echo "Downloads completed."