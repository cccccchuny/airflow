#!/bin/bash

# 이미지 리스트
images=(
  "docker.io/bitnami/minideb:stretch"
  "docker.io/bitnami/postgresql:11.5.0-debian-9-r60"
  "redis:6-buster"
  "apache/airflow:2.0.2"
  "apache/airflow:airflow-statsd-exporter-2021.04.28-v0.17.0"
)

# 이미지를 풀 받고 .tgz 파일로 세이브하는 함수
save_image() {
  local image=$1
  local image_file=$(echo $image | sed 's/[:\/]/-/g').tgz
  echo "Pulling image: $image"
  docker pull $image

  if [ $? -eq 0 ]; then
    echo "Saving image to: $image_file"
    docker save $image | gzip > $image_file
    echo "Image saved as $image_file"
  else
    echo "Failed to pull image: $image"
  fi
}

# 각 이미지에 대해 작업 수행
for image in "${images[@]}"; do
  save_image $image
done

echo "All images pulled and saved."