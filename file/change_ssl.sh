#!/bin/bash

# 변수 확인
# 입력 변수
# $1: 웹서버 바이너리
# $2: crt 경로
# $3: key 경로
# $4: chain 경로

# 변수 선언
WEBSERVER="$1"
PATH_CRT="$2"
PATH_KEY="$3"
PATH_CHAIN="$4"
BACKUP_DATE=$(date +"%Y-%m-%d")

# 모든 변수가 할당되었는지 확인
if [ -z "$WEBSERVER" ] || [ -z "$PATH_CRT" ] || [ -z "$PATH_KEY" ] || [ -z "$PATH_CHAIN" ]; then
    echo "Error: All variables (WEBSERVER, PATH_CRT, PATH_KEY, PATH_CHAIN) must be provided."
    exit 1
fi

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
