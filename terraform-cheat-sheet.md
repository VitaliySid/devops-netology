### Terraform

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