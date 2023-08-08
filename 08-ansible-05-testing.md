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

[Ссылка на тег vector_1.0.1](https://github.com/VitaliySid/vector-role/releases/tag/1.0.1)

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 