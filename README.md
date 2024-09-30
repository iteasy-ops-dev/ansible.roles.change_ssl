Ansible Role: Change SSL
=========

ssl 인증서를 변경합니다.

Requirements
------------
None.

Role Variables
--------------
- `defaults/main.yml` 참조
```yaml
domain_name: ""
src_cert_file: ""
src_key_file: ""
src_chain_file: ""
backup_date: "{{ ansible_date_time.date }}"
```

Dependencies
------------
None.

Example Playbook
----------------
- `test/` 참조
```yaml
- hosts: vms
  remote_user: root
  roles:
    - ansible.roles.change_ssl
```

License
------------
BSD



1. 변수를 받는다
=> 도메인이름, 인증서 키 경로(cert, key, chain)
 
2. 변수를 생성한다.
=> 백업날짜(당일)
 
3. 해당 서버 os를 찾는다
=> windows, redhat, debian
 
4. 해당 서버에서 동작하고 있는 웹서버를 찾는다
=> 아파치, nginx 등
 
5. 해당 도메인과 연결된 인증서 설정 파일을 찾는다.
 
6. 5에서 찾은 설정 파일에서 현재 적용되어 있는 인증서 파일의 위치를 찾는다
 
7. 인증서 파일을 같은 폴더에 파일이름+백업날짜 파일로 복사해 놓는다(백업용)
 
8. 인증서파일의 내용을 6번에서 찾은 파일에 내용에 덮어 씌운다
- nginx의 경우 key파일은 ssl_certificate_key로, cert와 chain을 합쳐서 ssl_certificate에 덮어 씌운다.
- 아파치일 경우 SSLCertificateFile, SSLCertificateKeyFile, SSLCertificateChainFile를 각각 덮어 씌운다
 
9. 웹서버 테스트를 진행한다.
=> nginx -t , httpd -t , apache2 -t 등
 
10. 웹서버 테스트가 성공이면 웹서버 재시작
 
11. 웹서버 테스트를 실패하면 7번에서 생성한 백업파일을 6번 파일 위치로 다시 변경
 
해당 내용으로 ssl을 갱신하는 플레이북을 만든다
os 별로 플레이북은 따로 만든다


1. 리눅스의 아파치 ssl 인증서를 갱신한다.

2. 변수를 받는다
=> 도메인이름, 인증서 키 경로(cert, key, chain)
 
3. 변수를 생성한다.
=> 백업날짜(당일)
 
4. 해당 도메인과 연결된 인증서 설정 파일을 찾는다.
 
5. 위에서 찾은 설정 파일에서 현재 적용되어 있는 인증서 파일의 위치를 찾는다
 
6. 인증서 파일을 같은 폴더에 파일이름+백업날짜 파일로 복사해 놓는다(백업용)
 
7. 인증서파일의 내용을 6번에서 찾은 파일에 내용에 덮어 씌운다
- 아파치일 경우 SSLCertificateFile, SSLCertificateKeyFile, SSLCertificateChainFile를 각각 덮어 씌운다
 
8. 웹서버 테스트를 진행한다.
=> nginx -t , httpd -t , apache2 -t 등
 
9.  웹서버 테스트가 성공이면 웹서버 재시작
 
10.  웹서버 테스트를 실패하면 7번에서 생성한 백업파일을 6번 파일 위치로 다시 변경
11.  로컬에 있는 인증서를 삭제한다.
12.  





