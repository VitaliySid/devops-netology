# Домашнее задание к занятию 16 «Платформа мониторинга Sentry»

## Задание 1

Так как Self-Hosted Sentry довольно требовательная к ресурсам система, мы будем использовать Free Сloud account.

Free Cloud account имеет ограничения:

- 5 000 errors;
- 10 000 transactions;
- 1 GB attachments.

Для подключения Free Cloud account:

- зайдите на sentry.io;
- нажмите «Try for free»;
- используйте авторизацию через ваш GitHub-аккаунт;
- далее следуйте инструкциям.

![](pic/10-monitoring-05-sentry-projects.png)  

## Задание 2

1. Создайте python-проект и нажмите `Generate sample event` для генерации тестового события.
1. Изучите информацию, представленную в событии.
1. Перейдите в список событий проекта, выберите созданное вами и нажмите `Resolved`.
1. В качестве решения задание предоставьте скриншот `Stack trace` из этого события и список событий проекта после нажатия `Resolved`.

![](pic/10-monitoring-05-sentry-test-project.png)

![](pic/10-monitoring-05-sentry-stacktrace.png)  

## Задание 3

1. Перейдите в создание правил алёртинга.
2. Выберите проект и создайте дефолтное правило алёртинга без настройки полей.
3. Снова сгенерируйте событие `Generate sample event`.
Если всё было выполнено правильно — через некоторое время вам на почту, привязанную к GitHub-аккаунту, придёт оповещение о произошедшем событии.
4. Если сообщение не пришло — проверьте настройки аккаунта Sentry (например, привязанную почту), что у вас не было 
`sample issue` до того, как вы его сгенерировали, и то, что правило алёртинга выставлено по дефолту (во всех полях all).
Также проверьте проект, в котором вы создаёте событие — возможно алёрт привязан к другому.
5. В качестве решения задания пришлите скриншот тела сообщения из оповещения на почте.
6. Дополнительно поэкспериментируйте с правилами алёртинга. Выбирайте разные условия отправки и создавайте sample events. 

![](pic/10-monitoring-05-sentry-alert.png)

## Задание повышенной сложности

1. Создайте проект на ЯП Python или GO (около 10–20 строк), подключите к нему sentry SDK и отправьте несколько тестовых событий.
2. Поэкспериментируйте с различными передаваемыми параметрами, но помните об ограничениях Free учётной записи Cloud Sentry.
3. В качестве решения задания пришлите скриншот меню issues вашего проекта и пример кода подключения sentry sdk/отсылки событий.

![](pic/10-monitoring-05-sentry-app-issues.png)  
![](pic/10-monitoring-03-grafana-app-error.png)  

Тестовое приложение:  
[app.py](assets/10-monitoring-05-sentry/app.py)  

<details>
<summary>Листинг кода</summary>

```python
#!/usr/bin/env python

import sentry_sdk

sentry_sdk.init(
    dsn="https://3a5eeb1598d25b05f63eff48bcb3ad63@o4506031283240960.ingest.sentry.io/4506031294840832",
    traces_sample_rate=1.0,
    profiles_sample_rate=1.0,
    environment="development",
)

try:
    file = open("license.key", "r")
    try:
        license_key = file.readline()
        if len(license_key) == 0:
            raise Exception("Invalid license key")
        
        print("Success")
    finally:
        file.close()
        
except Exception as e:
    sentry_sdk.capture_exception(e)
```
</details>