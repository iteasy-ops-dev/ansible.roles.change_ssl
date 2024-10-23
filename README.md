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
isRestart: 0
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
