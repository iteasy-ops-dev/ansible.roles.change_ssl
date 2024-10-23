#!/bin/bash

# 입력 변수 확인
# $1: 현재 crt 경로
# $2: 현재 key 경로
# $3: 현재 chain 경로
# $4: 대체할 crt 경로
# $5: 대체할 key 경로
# $6: 대체할 chain 경로

# 변수 선언
CURRUNT_PATH_CRT="$1"
CURRUNT_PATH_KEY="$2"
CURRUNT_PATH_CHAIN="$3"
NEW_PATH_CRT="$4"
NEW_PATH_KEY="$5"
NEW_PATH_CHAIN="$6"
WEBSERVER=$(ps -ef | grep -E 'nginx|httpd|apache' | grep -vE 'grep|php|awk' | awk '{print $8}' | head -n 1)
BACKUP_DATE=$(date +"%Y-%m-%d")

# 디버깅용 출력
echo "=== ✅ 입력 변수 확인 ==="
echo "현재 인증서 파일: $CURRUNT_PATH_CRT"
echo "현재 키 파일: $CURRUNT_PATH_KEY"
echo "현재 체인 파일: $CURRUNT_PATH_CHAIN"
echo "새 인증서 파일: $NEW_PATH_CRT"
echo "새 키 파일: $NEW_PATH_KEY"
echo "새 체인 파일: $NEW_PATH_CHAIN"
echo "웹서버: $WEBSERVER"
echo "백업 날짜: $BACKUP_DATE"
echo "========================="

# ==================== 함수
prune_tmp_file(
    echo "⚙️ 임시 폴더의 인증서 삭제 중..."
    rm -rf $NEW_PATH_CRT
    rm -rf $NEW_PATH_KEY
    rm -rf $NEW_PATH_CHAIN
    echo "✅ 임시 인증서 삭제 완료."
)
# ==================== 함수

# 모든 변수가 할당되었는지 확인
if [ -z "$CURRUNT_PATH_CRT" ] || [ -z "$CURRUNT_PATH_KEY" ] || [ -z "$CURRUNT_PATH_CHAIN" ] || [ -z "$NEW_PATH_CRT" ] || [ -z "$NEW_PATH_KEY" ] || [ -z "$NEW_PATH_CHAIN" ]; then
    echo "❌ Error: 모든 변수가 할당되지 않았습니다. 비어있는 변수를 확인하세요."
    prune_tmp_file
    exit 1
fi

# NGINX일 경우 종료
if [[ "$WEBSERVER" == *"nginx"* ]]; then
    echo "❌ Error: Nginx는 구현중에 있습니다."
    prune_tmp_file
    exit 1
fi

# 인증서 백업
echo "⚙️ 현재 인증서 백업 중..."
for PEM_FILE in "$CURRUNT_PATH_CRT" "$CURRUNT_PATH_KEY" "$CURRUNT_PATH_CHAIN"; do
    cp "$PEM_FILE" "$PEM_FILE.$BACKUP_DATE"
    echo "백업 파일 경로: $PEM_FILE.$BACKUP_DATE"
done
echo "✅ 백업 완료."

# 인증서 대체
echo "⚙️ 인증서 대체 중..."
for PEM_FILE in "$NEW_PATH_CRT" "$NEW_PATH_KEY" "$NEW_PATH_CHAIN"; do
    chown root "$PEM_FILE"
    chgrp root "$PEM_FILE"
    echo "소유자 및 그룹을 root로 변경: $PEM_FILE"
done
# mv "$NEW_PATH_CRT" "$CURRUNT_PATH_CRT"
# mv "$NEW_PATH_KEY" "$CURRUNT_PATH_KEY"
# mv "$NEW_PATH_CHAIN" "$CURRUNT_PATH_CHAIN"
mv "$NEW_PATH_CRT" "$CURRUNT_PATH_CRT.$BACKUP_DATE"
mv "$NEW_PATH_KEY" "$CURRUNT_PATH_KEY.$BACKUP_DATE"
mv "$NEW_PATH_CHAIN" "$CURRUNT_PATH_CHAIN.$BACKUP_DATE"
echo "✅ 인증서 파일 대체 완료."

prune_tmp_file

# Apache 설정 테스트 및 적용
echo "⚙️ Apache 설정 테스트 중..."
if $WEBSERVER -t; then
    echo "✅ Apache 설정에 문제가 없습니다. Apache를 재시작합니다."
    # $WEBSERVER -k graceful
    echo "✅ 인증서 연장 완료."
else
    echo "❌ Apache 설정에 오류가 있습니다."
    exit 1
fi
