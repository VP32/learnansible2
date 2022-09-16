# Учебный playbook для Ansible

Скачивает и устанавливает на указанных в inventory хостах Clickhouse, Vector и Lighthouse.

## Подготовка к запуску (необязательно)

Создать с помощью плана Terraform три виртуальные машины в Яндекс-облаке. План доступен в папке terraform.

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
 - группа lighthouse - хосты для разворачивания Vector

Если выполнялась подготовка к запуску, описанная выше, указать там ip-адреса полученных ВМ.

### Переменные

Используются роли для всех действий. Переменные, которые можно переопределить для ролей:
 
- vector_version - версия Vector
- vector_minor_version - минорная версия Vector, обычно 1
- nginx_root_folder - путь для сайта в Nginx
- lighthouse_dir - путь для установки Lighthouse

### Теги

 - clickhouse - установка Clickhouse
 - vector - установка Vector
 - lighthouse - установка Lighthouse
 - get_distrib - получение дистрибутивов на хост
 - install_distrib - установка дистрибутивов
 - check - проверка работоспособности
 - configure - конфигурационные задания