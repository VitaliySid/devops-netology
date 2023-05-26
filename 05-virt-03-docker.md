
# Домашнее задание к занятию 3. «Введение. Экосистема. Архитектура. Жизненный цикл Docker-контейнера»

## Задача 1

Сценарий выполнения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберите любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```

Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

Решение:  
```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker build -t qwuen/nginx-fork:0.0.1 .
[+] Building 10.7s (7/7) FINISHED

PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker run -p8080:80 -d qwuen/nginx-fork:0.0.1
aa2195e282df431e4da0a5442f41bbf9d51a2d974e16fccc2bcbdc8cdc68bc0c

PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker push qwuen/nginx-fork:0.0.1
The push refers to repository [docker.io/qwuen/nginx-fork]
...
0.0.1: digest: sha256:4db1c4aede50459d7a55fae2f4795c1cdcc1edd266bc6d3ac9714d3fa727f318 size: 1989
```
[Ссылка на репозиторий](https://hub.docker.com/repository/docker/qwuen/nginx-fork/general)  
[Dockerfile](/assets/05-virt-03-docker/Dockerfile)  

![](/pic/nginx-fork.png)

----

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
«Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- высоконагруженное монолитное Java веб-приложение;
```
Физический сервер или VM. Высоконагруженное приложение требует прямой доступ к ресурсам, сложная оркестрация и скейлинг тут не сильно нужны, возможно пара машин для приложения с балансировкой нагрузки.
```
- Nodejs веб-приложение;
```
Легковесное приложение, подойдет Docker для быстрой оркестрации.
```
- мобильное приложение c версиями для Android и iOS;
```
Аналогично приложению на Nodejs, Docker.
```
- шина данных на базе Apache Kafka;
```
Docker или VM. Сохранение данных на диск (Volume). Возможно создание создание кластера
```
- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;
```
Elasticsearch лучше делать на VM. Остальные сервисы  удобнее оркестрировать в Docker.
```
- мониторинг-стек на базе Prometheus и Grafana;
```
Prometheus как хранилище данных на VM или физический сервер, Grafana можно в Docker.
```
- MongoDB как основное хранилище данных для Java-приложения;
```
VM или физический сервер, зависит от потенциального объема данных
```
- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.
```
VM будет достаточно, главное делать бэкап конфигурации и данных на другой сервер.
```
----

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.  
```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker run -it --rm -d --name centos -v $PWD/data:/data centos:latest      
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
94d1da53f6796c4d0f9ffa5b5c4f4f40c7e680d479dd1088cb1ffcacb4533969
```
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.  
```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker run -it --rm -d --name debian -v $PWD/data:/data debian:latest      
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
bd73737482dd: Pull complete
Digest: sha256:432f545c6ba13b79e2681f4cc4858788b0ab099fc1cca799cc0fae4687c69070
Status: Downloaded newer image for debian:latest
0655793ce22360813d31b4e7d2acc528d8e912d97d776bd1562a2986168f10f7
```
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.  
```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker exec -it 94d1da53f679 /bin/bash
[root@94d1da53f679 /]# ls
bin  data  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@94d1da53f679 /]# touch /data/test.txt
[root@94d1da53f679 /]# ls /data
test.txt
[root@94d1da53f679 /]# exit
exit
```
- Добавьте ещё один файл в папку ```/data``` на хостовой машине.
```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> dir data 
    Directory: C:\projects\home\devops-netology\assets\05-virt-03-docker\data

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          26.05.2023    13:10              0 test.txt
-a---          26.05.2023    12:47              0 test-host.txt
```
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker ps
CONTAINER ID   IMAGE                    COMMAND                  CREATED          STATUS          PORTS                  NAMES
0655793ce223   debian:latest            "bash"                   24 seconds ago   Up 23 seconds                          debian
94d1da53f679   centos:latest            "/bin/bash"              2 minutes ago    Up 2 minutes                           centos
aa2195e282df   qwuen/nginx-fork:0.0.1   "/docker-entrypoint.…"   19 hours ago     Up 19 hours     0.0.0.0:8080->80/tcp   eager_kowalevski
PS C:\projects\home\devops-netology\assets\05-virt-03-docker> docker exec -it 0655793ce223 /bin/bash
root@0655793ce223:/# ls /data
test-host.txt  test.txt
root@0655793ce223:/#
```
----

## Задача 4 (*)

Воспроизведите практическую часть лекции самостоятельно.

Соберите Docker-образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

[Ссылка на репозиторий](https://hub.docker.com/repository/docker/qwuen/ansible/general)  

```
PS C:\projects\home\devops-netology\assets\05-virt-03-docker\ansible> docker build -t qwuen/ansible:2.9.24 .
[+] Building 403.6s (9/9) FINISHED
 => => naming to docker.io/qwuen/ansible:2.9.24  

 PS C:\projects\home\devops-netology\assets\05-virt-03-docker\ansible> docker push qwuen/ansible:2.9.24      
The push refers to repository [docker.io/qwuen/ansible]
5f70bf18a086: Pushed
adaea343fc8a: Pushed
62ff27c2e7d5: Pushed
9733ccc39513: Mounted from library/alpine
2.9.24: digest: sha256:e9a27f58433f5b3e6a90e4a9d74ab5835ca3682826550ee58720e4585fd78311 size: 1153
```
