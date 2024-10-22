#!/bin/bash

# 변수 확인
# 입력 변수
# $1: 사용자 계정 이름
# $2: 사용자 계정 비밀번호
# $3: DB 이름
# $4: DB 사용자 계정
# $5: DB 사용자 비밀번호
# $6: DB root 사용자 이름
# $7: DB root 사용자 비밀번호

# 변수 선언
USER_ACCOUNT="$1"
USER_PASSWORD="$2"
DB_NAME="$3"
DB_USER="$4"
DB_USER_PASSWORD="$5"
DB_ROOT_USER="$6"
DB_ROOT_PASSWORD="$7"