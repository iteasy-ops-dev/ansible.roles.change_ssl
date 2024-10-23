#!/bin/bash

# 변수 확인
# 입력 변수
# $1: crt 경로
# $2: key 경로
# $3: chain 경로

# 변수 선언
PATH_CRT="$1"
PATH_KEY="$2"
PATH_CHAIN="$3"
WEBSERVER=$(ps -ef | grep -E 'nginx|httpd|apache' | grep -vE 'grep|php|awk' | awk '{print $8}' | head -n 1 | tr -d ':')
BACKUP_DATE=$(date +"%Y-%m-%d")

# 모든 변수가 할당되었는지 확인
if [ -z "$PATH_CRT" ] || [ -z "$PATH_KEY" ] || [ -z "$PATH_CHAIN" ]; then
    echo "Error: All variables (WEBSERVER, PATH_CRT, PATH_KEY, PATH_CHAIN) must be provided."
    exit 1
fi

# 디버깅용 출력
echo "=== ✅ 입력 변수 확인 ==="
echo "PATH_CRT: $PATH_CRT"
echo "PATH_KEY: $PATH_KEY"
echo "PATH_CHAIN: $PATH_CHAIN"
echo "WEBSERVER: $WEBSERVER"
echo "BACKUP_DATE: $BACKUP_DATE"
echo "===================="

# PEM 파일 배열 선언
PEM_FILES=(
    $PATH_CRT
    $PATH_KEY
    $PATH_CHAIN
)

# PEM 파일 백업
for PEM_FILE in "${PEM_FILES[@]}"; do
    cp "$PEM_FILE" "$PEM_FILE.$BACKUP_DATE"
done

echo "Backup completed for all PEM files."
