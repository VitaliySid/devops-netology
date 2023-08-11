# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule: `pip3 install "molecule==3.5.2"` и драйвера `pip3 install molecule_docker molecule_podman`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

### Molecule

<details>
<summary>Задача</summary>

1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.

```
qwuen@MSI:/mnt/d/projects/ansible-clickhouse$ sudo molecule test -s centos_7
PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
ok: [centos_7] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
centos_7                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

```sh
qwuen@MSI:/mnt/d/projects/vector-role$ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /mnt/d/projects/vector-role/molecule/default successfully.
```
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
</details>

<details>
<summary>Разультаты теста</summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/vector-role$ molecule test -s centos-7
WARNING  The scenario config file ('/mnt/c/projects/home/vector-role/molecule/centos-7/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration.
INFO     centos-7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/qwuen/.cache/ansible-compat/f5bcd7/modules:/home/qwuen/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/qwuen/.cache/ansible-compat/f5bcd7/collections:/home/qwuen/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/qwuen/.cache/ansible-compat/f5bcd7/roles:/home/qwuen/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/qwuen/.cache/ansible-compat/f5bcd7/roles/qwuen.vector_role symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running centos-7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos-7 > lint
INFO     Lint is disabled.
INFO     Running centos-7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos-7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos-7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos-7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running centos-7 > syntax

playbook: /mnt/c/projects/home/vector-role/molecule/centos-7/converge.yml
INFO     Running centos-7 > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'image': 'local/c7-systemd', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'image': 'local/c7-systemd', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'image': 'local/c7-systemd', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'image': 'local/c7-systemd', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/local/c7-systemd)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'image': 'local/c7-systemd', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos-7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '766961159435.451140', 'results_file': '/home/qwuen/.ansible_async/766961159435.451140', 'changed': True, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'image': 'local/c7-systemd', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running centos-7 > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running centos-7 > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos-7]

TASK [Install sudo] ************************************************************
changed: [centos-7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : include_tasks] *********************************************
included: /mnt/c/projects/home/vector-role/tasks/install/yum.yml for centos-7

TASK [vector-role : Get vector distrib] ****************************************
changed: [centos-7]

TASK [vector-role : Install vector package] ************************************
changed: [centos-7]

TASK [vector-role : Redefine vector config name] *******************************
changed: [centos-7]

TASK [vector-role : Create vector config] **************************************
changed: [centos-7]

TASK [vector-role : Flush handlers] ********************************************

RUNNING HANDLER [vector-role : Start Vector service] ***************************
changed: [centos-7]

PLAY RECAP *********************************************************************
centos-7                   : ok=8    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running centos-7 > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos-7]

TASK [Install sudo] ************************************************************
ok: [centos-7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : include_tasks] *********************************************
included: /mnt/c/projects/home/vector-role/tasks/install/yum.yml for centos-7

TASK [vector-role : Get vector distrib] ****************************************
ok: [centos-7]

TASK [vector-role : Install vector package] ************************************
ok: [centos-7]

TASK [vector-role : Redefine vector config name] *******************************
ok: [centos-7]

TASK [vector-role : Create vector config] **************************************
ok: [centos-7]

TASK [vector-role : Flush handlers] ********************************************

PLAY RECAP *********************************************************************
centos-7                   : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running centos-7 > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running centos-7 > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gather Installed Packages] ***********************************************
ok: [centos-7]

TASK [Assert Vector Packages] **************************************************
ok: [centos-7] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validate Vector Config] **************************************************
changed: [centos-7]

TASK [Assert Vector Config Validation Status] **********************************
ok: [centos-7] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Collect Facts About System Services] *************************************
ok: [centos-7]

TASK [Assert Vector Systemd Unit Status] ***************************************
ok: [centos-7] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Assert Vector Systemd Unit State] ****************************************
ok: [centos-7] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
centos-7                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running centos-7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos-7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos-7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos-7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```
</details>

[Ссылка на репозиторий](https://github.com/VitaliySid/vector-role/blob/1.0.1/README.md)  
[Ссылка на тег vector_1.0.1](https://github.com/VitaliySid/vector-role/releases/tag/1.0.1)

### Tox

<details>
<summary>Задача</summary>
1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
</details>  


[Ссылка на tox.ini](/assets/08-ansible-05-testing/tox.ini)  
[Ссылка на tag 1.0.2](https://github.com/VitaliySid/vector-role/releases/tag/1.0.2)  

<details>
<summary>Решение</summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/vector-role$ molecule init scenario tox --driver-name=docker
INFO     Initializing new scenario tox...
INFO     Initialized scenario in /mnt/c/projects/home/vector-role/molecule/tox successfully.
```

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/vector-role$ molecule matrix -s tox test
INFO     Test matrix
---
tox:
  - destroy
  - create
  - converge
  - destroy
```

```sh
[root@e1e9854cc274 vector-role]# tox -v
using tox.ini: /opt/vector-role/tox.ini (pid 2674)
using tox-3.28.0 from /usr/local/lib/python3.6/site-packages/tox/__init__.py (pid 2674)
py3.9-ansible50 reusing: /opt/vector-role/.tox/py3.9-ansible50
[2679] /opt/vector-role$ /opt/vector-role/.tox/py3.9-ansible50/bin/python -m pip freeze >.tox/py3.9-ansible50/log/py3.9-ansible50-3.log
py3.9-ansible50 installed: ansible==4.10.0,ansible-compat==1.0.0,ansible-core==2.11.12,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.2.1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.7.22,cffi==1.15.1,chardet==5.0.0,charset-normalizer==2.0.12,click==8.0.4,click-help-colors==0.9.1,commonmark==0.9.1,cookiecutter==1.7.3,cryptography==40.0.2,dataclasses==0.8,distro==1.8.0,docker==5.0.3,enrich==1.2.7,idna==3.4,importlib-metadata==4.8.3,Jinja2==3.0.3,jinja2-time==0.2.0,jmespath==0.10.0,lxml==4.9.3,MarkupSafe==2.0.1,molecule==3.5.2,molecule-docker==1.1.0,molecule-podman==1.1.0,packaging==21.3,paramiko==2.12.0,pathspec==0.9.0,pluggy==1.0.0,poyo==0.5.0,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,pyparsing==3.1.1,python-dateutil==2.8.2,python-slugify==6.1.2,PyYAML==5.4.1,requests==2.27.1,resolvelib==0.5.4,rich==12.6.0,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.1.1,urllib3==1.26.16,wcmatch==8.3,websocket-client==1.3.1,yamllint==1.26.3,zipp==3.6.0
py3.9-ansible50 run-test-pre: PYTHONHASHSEED='1770191783'
py3.9-ansible50 run-test: commands[0] | molecule test -s tox --destroy always
[2681] /opt/vector-role$ /opt/vector-role/.tox/py3.9-ansible50/bin/molecule test -s tox --destroy always
/opt/vector-role/.tox/py3.9-ansible50/lib/python3.6/site-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.16) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.
/opt/vector-role/.tox/py3.9-ansible50/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
INFO     tox scenario test matrix: destroy, create, converge, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/b984a4/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/b984a4/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/b984a4/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/hosts.yml linked to /root/.cache/molecule/vector-role/tox/inventory/hosts
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/group_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/group_vars
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/host_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/host_vars
INFO     Running tox > destroy
INFO     Sanity checks: 'docker'
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
/opt/vector-role/.tox/py3.9-ansible50/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
changed: [localhost] => (item=centos-7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos-7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/hosts.yml linked to /root/.cache/molecule/vector-role/tox/inventory/hosts
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/group_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/group_vars
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/host_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/host_vars
INFO     Running tox > create
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
/opt/vector-role/.tox/py3.9-ansible50/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos-7)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '920584647385.2889', 'results_file': '/root/.ansible_async/920584647385.2889', 'changed': True, 'failed': False, 'item': {'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos-7', 'pre_build_image': True, 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup:ro']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/hosts.yml linked to /root/.cache/molecule/vector-role/tox/inventory/hosts
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/group_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/group_vars
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/host_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/host_vars
INFO     Running tox > converge
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
/opt/vector-role/.tox/py3.9-ansible50/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
ok: [centos-7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : include_tasks] *********************************************
included: /opt/vector-role/tasks/install/yum.yml for centos-7

TASK [vector-role : Get vector distrib] ****************************************
changed: [centos-7]

TASK [vector-role : Install vector package] ************************************
changed: [centos-7]

TASK [vector-role : Redefine vector config name] *******************************
changed: [centos-7]

TASK [vector-role : Create vector config] **************************************
changed: [centos-7]

TASK [vector-role : Flush handlers] ********************************************

RUNNING HANDLER [vector-role : Start Vector service] ***************************
changed: [centos-7]

PLAY RECAP *********************************************************************
centos-7                   : ok=7    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/hosts.yml linked to /root/.cache/molecule/vector-role/tox/inventory/hosts
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/group_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/group_vars
INFO     Inventory /opt/vector-role/molecule/tox/../resources/inventory/host_vars/ linked to /root/.cache/molecule/vector-role/tox/inventory/host_vars
INFO     Running tox > destroy
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
/opt/vector-role/.tox/py3.9-ansible50/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
changed: [localhost] => (item=centos-7)

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos-7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
_______________________________________________________ summary ________________________________________________________
  py3.9-ansible50: commands succeeded
  congratulations :)
[root@e1e9854cc274 vector-role]#
```
</details>