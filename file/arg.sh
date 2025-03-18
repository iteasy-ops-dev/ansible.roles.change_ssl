#!/bin/bash

# 변수 선언
# NEW_PATH_CRT="$1"
# NEW_PATH_KEY="$2"
# NEW_PATH_CHAIN="$3"
# CURRUNT_PATH_CRT="$4"
# CURRUNT_PATH_KEY="$5"
# CURRUNT_PATH_CHAIN="$6"
# IS_RESTART="$7" # 0: false, 1: true
IS_RESTART=0 # 0: false, 1: true
# WEBSERVER=$(ps -ef | grep -E 'nginx|httpd|apache' | grep -vE 'grep|php|awk' | awk '{print $8}' | head -n 1)
BACKUP_DATE=$(date +"%Y-%m-%d")

OPTS=$(getopt -o "r" -l "newcrt:,newkey:,newchain:,curcrt:,curkey:,curchain:" -- "$@")
eval set -- "$OPTS"

while [[ $# -gt 0 ]]; do
  case "$1" in
  --newcrt)
    NEW_PATH_CRT=$2
    shift 2
    ;;
  --newkey)
    NEW_PATH_KEY=$2
    shift 2
    ;;
  --newchain)
    NEW_PATH_CHAIN=$2
    shift 2
    ;;
  --curchain)
    CURRUNT_PATH_CHAIN=$2
    shift 2
    ;;
  --curkey)
    CURRUNT_PATH_KEY=$2
    shift 2
    ;;
  --curcrt)
    CURRUNT_PATH_CRT=$2
    shift 2
    ;;
  -r)
    IS_RESTART=1
    shift 1
    ;;
  --)
    shift
    break
    ;;
  *)
    echo "invalid Option: $1"
    exit 1
    ;;
  esac
done

# 디버깅용 출력
echo "=== ✅ 입력 변수 확인 ==="
echo "새 인증서 파일: $NEW_PATH_CRT"
echo "새 키 파일: $NEW_PATH_KEY"
echo "새 체인 파일: $NEW_PATH_CHAIN"
echo "현재 인증서 파일: $CURRUNT_PATH_CRT"
echo "현재 키 파일: $CURRUNT_PATH_KEY"
echo "현재 체인 파일: $CURRUNT_PATH_CHAIN"
echo "재시작 여부: $IS_RESTART"
echo "웹서버: $WEBSERVER"
echo "백업 날짜: $BACKUP_DATE"
echo "========================="
