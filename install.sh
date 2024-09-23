# install.sh 수정
# 현재 경로를 명확히 지정
helm install airflow ./airflow --namespace airflow --create-namespace -f ./airflow/values.yaml
