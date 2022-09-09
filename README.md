# Учебный playbook для Ansible

Скачивает и устанавливает на указанных в inventory хостах Clickhouse и Vector.

## Подготовка к запуску (необязательно)

Создать с помощью плана Terraform виртуальную машину в Яндекс-облаке. План доступен в папке terraform.

Для запуска плана прописать в файле terraform/vars.tf параметры Яндекс-облака:
    
- токен
-  id облака
-  id папки
-  регион
-  id образа ВМ. Предпочтительно использовать CentOS.

Перед запуском terraform apply  сгенерировать пару ключей (по пути ~/.ssh/id_yc_rsa.pub, либо исправить в main.tf) для ВМ. 
В результате terraform apply будет выведен ip-адрес машины.

## Параметры

### Inventory
Настраивать в файле inventory/prod.yml:
 - группа clickhouse - хосты для разворачивания Clickhouse
 - группа vector - хосты для разворачивания Vector

Если выполнялась подготовка к запуску, описанная выше, указать там ip-адрес полученной ВМ.

### Переменные

Указаны в файлах в папке group_vars 
 
- clickhouse_version - версия Clickhouse
- clickhouse_packages - набор пакетов для установки Clickhouse
- vector_version - версия Vector
- vector_minor_version - минорная версия Vector, обычно 1

### Теги

 - clickhouse - установка Clickhouse
 - vector - установка Vector
 - get_distrib - получение дистрибутивов на хост
 - install_distrib - установка дистрибутивов
 - check - проверка работоспособности