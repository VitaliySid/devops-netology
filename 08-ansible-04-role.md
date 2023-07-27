# Домашнее задание к занятию 4 «Работа с roles»

#### Доп. материалы
- Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse)
- [LightHouse](https://youtu.be/ymlrNlaHzIY?t=929)

<details>
<summary>Требования</summary>

1. Создайте в старой версии playbook файл `requirements.yml` и заполните его содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.11.0"
       name: clickhouse 
   ```

2. При помощи `ansible-galaxy` скачайте себе эту роль.
3. Создайте новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 
5. Перенести нужные шаблоны конфигов в `templates`.
6. Опишите в `README.md` обе роли и их параметры. Пример качественной документации ansible role [по ссылке](https://github.com/cloudalchemy/ansible-prometheus).
7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.
9. Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения `roles` с `tasks`.
10. Выложите playbook в репозиторий.
11. В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.
</details>

### Инфраструктура:
Разворачивание инфраструктуры происходит с помощью `vagrant`, командой:  
`vagrant up`  

### Playbook
Playbook производит настройку трех ВМ:  
- `vector-01` - для сбора логов на сервере и передачу на сервер Сlickhouse
- `clickhouse-01` - для разворачивания БД ClickHouse и хранения логов
- `lighthouse-01` - для отображения логов из ClickHouse

[site.yml](/assets/08-ansible-04-role/playbook/site.yml)

## Variables
Значения переменных устанавливаются в файлах `vars.yml` в соответствующих директориях в `group_vars`  
Требуется задать следующие параметры:
- `clickhouse_version`, `vector_version` - версии устанавливаемых приложений;
- `database_name` - имя базы данных в `clickhouse`;
- `table_name` - имя таблицы в `clickhouse`;
- `vector_config` - содержимое конфигурационного файла для приложения `vector`;
- `lighthouse_home_dir` - домашняя директория `lighthouse` 
- `nginx_config_dir` - директория расположения конфига `nginx`
---

## Tags

`ping` - Проверяет доступность серверов  
`clickhouse` - производит полную конфигурацию сервера `clickhouse-01`;  
`vector` - производит полную конфигурацию сервера `vector-01`;  
`lighthouse` - производит полную конфигурацию сервера `lighthouse-01`;

Пример использования тегов:  
- `ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse --ask-vault-pass`  
- `ansible-playbook -i inventory/prod.yml site.yml --tags vector --ask-vault-pass --skip-tags always`
- ` ansible-playbook -i inventory/prod.yml site.yml --tags lighthouse --skip-tags always`

Пароль: `12345`

---

Requirements
------------
- [clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse.git) - роль для установки приложения `clickhouse`  
- [vector-role](https://github.com/VitaliySid/vector-role.git) - роль для установки приложения `vector`  
- [lighthouse-role](https://github.com/VitaliySid/lighthouse-role.git) - роль для установки приложения `lighthouse`

Установка зависимостей:  
`ansible-galaxy install -r requirements.yml -p roles`