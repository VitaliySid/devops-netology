# Домашнее задание к занятию 2 «Работа с Playbook»

#### Доп. материалы
- [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs)
- [Vector](https://www.youtube.com/watch?v=CgEhyffisLY)

<details>
<summary>Требования</summary>

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.
</details>

<details>
<summary>Установка Clickhouse</summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-02-playbook/playbook$ ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse

PLAY [Ping] ************************************************************************************************************

PLAY [Install Clickhouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ******************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] *************************************************************************************
changed: [clickhouse-01]

TASK [Enable remote connections to clickhouse server] ******************************************************************
changed: [clickhouse-01]

TASK [Flush handlers] **************************************************************************************************

RUNNING HANDLER [Start clickhouse service] *****************************************************************************
changed: [clickhouse-01]

TASK [Create database] *************************************************************************************************
changed: [clickhouse-01]

TASK [Create table] ****************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector manual] *******************************************************************************************

PLAY RECAP *************************************************************************************************************
clickhouse-01              : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0

```

</details>

<details>
<summary>Проверка установки Clickhouse</summary>

```sh
C:\Users\v_sid>ssh vagrant@192.168.56.10
The authenticity of host '192.168.56.10 (192.168.56.10)' can't be established.
ECDSA key fingerprint is SHA256:RnTAaq3Fh1czxOO8aigpNr1NxDRvgb/+CzQrNQEo8oQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.56.10' (ECDSA) to the list of known hosts.
Last login: Tue Jul 18 08:19:55 2023 from 192.168.56.1
[vagrant@clickhouse-01 ~]$ clickhouse-client
ClickHouse client version 22.3.3.44 (official build).
Connecting to localhost:9000 as user default.
Connected to ClickHouse server version 22.3.3 revision 54455.

clickhouse-01 :) select * from logs.dummy_logs

SELECT *
FROM logs.dummy_logs

Query id: e1abb83f-28a7-4bae-bf83-4ad2f034586e

┌─appname─────┬─facility─┬─hostname───┬─message───────────────────────────────────────────────────────────────────────────────────┬─msgid─┬─procid─┬─severity─┬───────────────timestamp─┬─version─┐
│ Karimmove   │ cron     │ up.net     │ A bug was encountered but not in Vector, which doesn't have bugs                          │ ID565 │   1589 │ alert    │ 2023-07-18 08:26:13.531 │       1 │
│ shaneIxD    │ local0   │ names.net  │ Take a breath, let it go, walk away                                                       │ ID356 │   7659 │ notice   │ 2023-07-18 08:26:14.534 │       1 │
│ meln1ks     │ ftp      │ random.de  │ A bug was encountered but not in Vector, which doesn't have bugs                          │ ID760 │   9080 │ alert    │ 2023-07-18 08:26:15.535 │       2 │
│ shaneIxD    │ kern     │ random.com │ Take a breath, let it go, walk away                                                       │ ID889 │    891 │ emerg    │ 2023-07-18 08:26:16.533 │       2 │
```

</details>

<details>
<summary>Установка Vector</summary>

```sh
qwuen@LAPTOP-2QLN04RI:/mnt/c/projects/home/devops-netology/assets/08-ansible-02-playbook/playbook$ ansible-playbook -i inventory/prod.yml site.yml --tags vector

PLAY [Ping] ************************************************************************************************************

PLAY [Install Clickhouse] **********************************************************************************************

PLAY [Install Vector manual] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
The authenticity of host '192.168.56.15 (192.168.56.15)' can't be established.
ECDSA key fingerprint is SHA256:tbnHxBx+bLQq+39m1ja8Fm/G/RqIKrBaVzrmr+PaK58.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [vector-01]

TASK [Get vector distrib] **********************************************************************************************
changed: [vector-01]

TASK [Install vector package] ******************************************************************************************
changed: [vector-01]

TASK [Redefine vector config name] *************************************************************************************
changed: [vector-01]

TASK [Create vector config] ********************************************************************************************
changed: [vector-01]

TASK [Flush handlers] **************************************************************************************************

RUNNING HANDLER [Start Vector service] *********************************************************************************
changed: [vector-01]

PLAY RECAP *************************************************************************************************************
vector-01                  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
</details>

<details>
<summary>Проверка установки Vector</summary>

```sh
C:\Users\v_sid>ssh vagrant@192.168.56.15
The authenticity of host '192.168.56.15 (192.168.56.15)' can't be established.
ECDSA key fingerprint is SHA256:tbnHxBx+bLQq+39m1ja8Fm/G/RqIKrBaVzrmr+PaK58.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.56.15' (ECDSA) to the list of known hosts.
Last login: Tue Jul 18 08:26:13 2023 from 192.168.56.1
[vagrant@vector-01 ~]$ sudo systemctl status vector
● vector.service - Vector
   Loaded: loaded (/usr/lib/systemd/system/vector.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-07-18 08:26:13 UTC; 12min ago
     Docs: https://vector.dev
  Process: 3857 ExecStartPre=/usr/bin/vector validate (code=exited, status=0/SUCCESS)
 Main PID: 3859 (vector)
   CGroup: /system.slice/vector.service
           └─3859 /usr/bin/vector

Jul 18 08:26:13 vector-01 vector[3857]: √ Health check "to_clickhouse"
Jul 18 08:26:13 vector-01 vector[3857]: ------------------------------------
Jul 18 08:26:13 vector-01 vector[3857]: Validated
Jul 18 08:26:13 vector-01 systemd[1]: Started Vector.
Jul 18 08:26:13 vector-01 vector[3859]: 2023-07-18T08:26:13.479915Z  INFO vector::app: Log level is enabled. lev...info"
Jul 18 08:26:13 vector-01 vector[3859]: 2023-07-18T08:26:13.480232Z  INFO vector::app: Loading configs. paths=["...aml"]
Jul 18 08:26:13 vector-01 vector[3859]: 2023-07-18T08:26:13.525531Z  INFO vector::topology::running: Running hea...ecks.
Jul 18 08:26:13 vector-01 vector[3859]: 2023-07-18T08:26:13.525660Z  INFO vector: Vector has started. debug="fal...4470"
Jul 18 08:26:13 vector-01 vector[3859]: 2023-07-18T08:26:13.527450Z  INFO vector::internal_events::api: API serv...round
Jul 18 08:26:13 vector-01 vector[3859]: 2023-07-18T08:26:13.536873Z  INFO vector::topology::builder: Healthcheck passed.
Hint: Some lines were ellipsized, use -l to show in full.
```
</details>

[Ссылка на site.yml](/assets/08-ansible-02-playbook/playbook/site.yml)  

---

### Инфраструктура:

Инфраструктура разворачивается с помощью `Vagrant`  
Команда: `\\devops-netology\assets\08-ansible-02-playbook\playbook>vagrant up`  

[Ссылка на Vagrantfile](/assets/08-ansible-02-playbook/playbook/Vagrantfile)  

После выполнения команды будет поднято две ВМ:  
|Host|IpAddress|
|----|----|
|clickhouse-01|192.168.56.10|
|vector-01|192.168.56.15|

### Playbook
Playbook производит установку и настройку приложений для сбора логов на сервере `vector-01` и дальнейшую передачу логов на сервер `clickhouse-01`

## Variables
Значения переменных устанавливаются в файлах `vars.yml` в соответствующих директориях в `group_vars`  
Требуется задать следующие параметры:
- `clickhouse_version`, `vector_version` - версии устанавливаемых приложений;
- `clickhouse_database_name` - имя базы данных в `clickhouse`;
- `clickhouse_create_table_name` - имя таблицы в `clickhouse`;
- `vector_config` - содержимое конфигурационного файла для приложения `vector`;

## Tags

`ping` - Проверяет доступность серверов  
`clickhouse` - производит полную конфигурацию сервера `clickhouse-01`;  
`vector` - производит полную конфигурацию сервера `vector-01`;  
`vector_config` - производит изменение в конфиге приложения `vector`;  

---