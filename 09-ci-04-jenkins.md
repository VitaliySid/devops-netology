# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

## Основная часть

<details>
<summary>Требования</summary>

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.
</details>

Git:  
![](pic/09-ci-04-jenkins-git.png)  

Nodes:  
![](pic/09-ci-04-jenkins-nodes.png)  

All jobs:  
![](pic/09-ci-04-jenkins-all.png)  

Freestyle Job:  
![](pic/09-ci-04-jenkins-freestyle.png)  
[FreesyleJob](assets/09-ci-04-jenkins/FreesyleJob)

Declarative Pipeline Job:  
[vector-role](https://github.com/VitaliySid/vector-role/tree/main)  
[DeclarativeJenkinsfile](assets/09-ci-04-jenkins/DeclarativeJenkinsfile)  

ScriptedJob:  
![](pic/09-ci-04-jenkins-scripted.png)  
[ScriptedJob](assets/09-ci-04-jenkins/ScriptedJob)  