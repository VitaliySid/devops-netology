# Домашнее задание к занятию 1 «Введение в Ansible»

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
<details>
<summary>Результат: </summary>

```sh
C:\projects\home\devops-netology\assets\08-ansible-01-base>wsl
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base$ cd playbook/
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
</details>

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.  
[examp.yml](assets/08-ansible-01-base/playbook/group_vars/all/examp.yml)  
```sh
TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.  
[docker-compose.yml](assets/08-ansible-01-base/docker-compose.yml)  

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.  
<details>
<summary>Результат: </summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
</details>

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.  
deb: [examp.yml](assets/08-ansible-01-base/playbook/group_vars/deb/examp.yml)  
el: [examp.yml](assets/08-ansible-01-base/playbook/group_vars/el/examp.yml)  

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.  
```sh
TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.  
<details>
<summary>Результат: </summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ cat group_vars/deb/examp.yml
$ANSIBLE_VAULT;1.1;AES256
65643639323139643266363737366335633033393830376537663965316663393464643162636263
3837623866366365303163663832663634633338323938310a303031623261326364333761336466
63376235303930323161343033656666636238303232356161363662653761386430373535613866
6337346533626538370a636436313661393366383234393337303038346265366561613935313233
31646237633435623835626334383765323765386237663563656462623435386266636331616565
3539623838623238333264343933313732333139363166346362
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ cat group_vars/el/examp.yml
$ANSIBLE_VAULT;1.1;AES256
33386534323163316234646130343862653835306236366239346466326662303066613431353663
3630653535343662383934613438613163623563333833300a633265633365613438653566353565
32373938353430646163326136623631626563393838643833343735623639373766623961613735
6439633031666136350a373232383364613137306461393230376535666631633362306232626664
34323062656130333538336339646339373935393161613238653032323739666361313132373766
3932333632323866663962613661666633636135396134653237
```
</details>

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.  
<details>
<summary>Результат: </summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ********************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *******************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
</details>

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base$ ansible-doc -t connection local
> ANSIBLE.BUILTIN.LOCAL    (/home/qwuen/.local/lib/python3.8/site-packages/ansible/plugins/connection/local.py)

        This connection plugin allows ansible to execute tasks on the Ansible 'controller'
        instead of on a remote host.
```
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.  

[docker-compose.yml](assets/08-ansible-01-base/playbook/inventory/prod.yml)  

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.  

<details>
<summary>Результат: </summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "local default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
</details>

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
