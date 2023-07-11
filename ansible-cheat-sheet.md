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

Команды:  
```sh
ansible -m ping localhost #Сделаем ping на localhost
ansible -m ping -i inventory.yml all #Сделаем ping на всех хостах из inventory
ansible -m ping -i inventory.yml <group_name> #Сделаем ping на всех хостах группы <group_name>
ansible-playbook -i inventory/test.yml site.yml #Запуск site на хостах из test
ansible-inventory -i inventory.yml --graph <group_name> #Показать хосты группы
ansible-inventory -i inventory.yml --list #Показать все переменные всех хостов из inventory
ansible-inventory -i inventory.yml --list <hostname> #Показать все переменные хоста из inventory
ansible-doc <plugin_name> #Показать документацию по плагину
ansible-vault create <filename> #Создать новый зашифрованный файла
ansible-vault edit <filename> #Отредактировать зашифрованный файла
ansible-vault view <filename> #Просмотреть зашифрованный файла
ansible-vault rekey <filename> #Поменять пароль у файла
ansible-vault decrypt <filename> #Расшифровать файл

```