#!/bin/bash

# 저장된 이미지 파일 경로 리스트
image_files=(
  "docker.io-bitnami-minideb-stretch.tgz"
  "docker.io-bitnami-postgresql-11.5.0-debian-9-r60.tgz"
  "redis-6-buster.tgz"
  "apache-airflow-2.0.2.tgz"
  "apache-airflow-airflow-statsd-exporter-2021.04.28-v0.17.0.tgz"
)

# 이미지를 로드하는 함수
load_image() {
  local image_file=$1
  echo "Loading image from: $image_file"
  podman load -i $image_file

  if [ $? -eq 0 ]; then
    echo "Successfully loaded image from $image_file"
  else
    echo "Failed to load image from $image_file"
  fi
}

# 각 이미지 파일에 대해 작업 수행
for image_file in "${image_files[@]}"; do
  if [ -f $image_file ]; then
    load_image $image_file
  else
    echo "Image file not found: $image_file"
  fi
done

echo "All images loaded."
