### Ansible

Установка:  
```
yum install ansbile
apt install ansible
pip3 install ansible --user
```

Утилиты:  
- `Ansible` – определение и запуск playbook из одного task на наборе hosts
- `Ansible-playbook` — запуск полноценного playbook
- `Ansible-vault` — шифрование хранилища методом AES256
- `Ansible-galaxy` — скачивание roles и collections
- `Ansible-lint` — используется для проверки синтаксиса
- `Ansible-console` — консоль для запуска tasks
- `Ansible-config` — просмотр и управление конфигурацией - `Ansible
- `Ansible-doc` — просмотр документации plugins
- `Ansible-inventory` — просмотр информации о hosts из inventory
- `Ansible-pull` — скачивание playbook и запуск на localhost
- `Ansible-test` — тестирование collections

<details>
<summary>Полезные утилиты</summary>

- [terraform-switcher](https://tfswitch.warrensbox.com/) 
Инструмент командной строки позволяет легко переключаться
между различными версиями Terraform с помощью команды `tfswitch <version>`

- [terraform-docs](https://terraform-docs.io/user-guide/introduction/) 
Утилита автоматически генерирует описание ресурсов, переменных и зависимостей.  
Console команда:  
`terraform-docs markdown table --output-file README.md .`  
Docker команда:
```
docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u)\
quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs
```
- [terraform-switcher](https://tfswitch.warrensbox.com/) 
Инструмент командной строки позволяет легко переключаться
между различными версиями Terraform с помощью команды `tfswitch <version>`
</details>

---