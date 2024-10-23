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

PEM_FILES=(
    $PATH_CRT
    $PATH_KEY
    $PATH_CHAIN
)

for PEM_FILE in "${PEM_FILES[@]}"; do
    cp $PEM_FILE $PEM_FILE.$BACKUP_DATE
done

