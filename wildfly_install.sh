#/bin/bash
### Скрипт по установке Wildfly на Centos
### Переменные
echo "Введите путь куда скачать дистрибутив (по умолчанию путь УЖЕ идет с ~/)"
read DISTR_DIR
sleep 1
echo "Введите ссылку на архив .tar дистрибутива Wildfly"
read WILD_DIST

### Установка Java и проверка версии
clear
sleep 1
echo "Устанавливаем пакет Java 11"
sudo yum install java-11-openjdk-devel
sleep 2
clear
echo "Проверяем версию Java"
echo " "
java --version
sleep 2
clear

### Создание папки с дистрибутивом
sudo mkdir $DISTR_DIR

### Загрузка архива релиза WildFly
sleep 2
echo "Загрузим архив релиза в папку дистрибутива"
cd ~/$DISTR_DIR
sudo wget $WILD_DIST
sleep 2
clear

### Распаковка архива и добавление файлов в директорию /opt/wildfly
sleep 2
echo "Распакуем архив и добавим в директорию /opt/wildfly"
cd ~/$DISTR_DIR
sudo tar xvf wildfly-*.tar.gz -C /opt/wildfly --strip 1
sleep 2
clear

### Добавление системного пользователя и группу, которые будут запускать службу WildFly
echo "Создание системного пользователя и группу, которые будут запускать службу WildFly"
sudo groupadd --system wildfly
sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly
sleep 1
clear

### Создание каталога конфигураций WildFly
echo "Создание каталога конфигураций WildFly"
sudo mkdir /etc/wildfly
sleep 1
clear

### Копирование сервиса WildFly systemd, файл конфигурации и шаблоны стартовых сценариев из каталога
echo "Копирование сервиса WildFly systemd, файл конфигурации и шаблоны стартовых сценариев из каталога"
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo chmod +x /opt/wildfly/bin/launch.sh
sleep 1
clear

### Установка разрешений /opt/wildfly
echo "Установка разрешений /opt/wildfly"
sudo chown -R wildfly:wildfly /opt/wildfly
sleep 1
clear

### Перезагрузка службы systemd
echo "Перезагрузка службы systemd и запуск сервиса Wildfly"
sudo systemctl daemon-reload
sudo semanage fcontext  -a -t bin_t  "/opt/wildfly/bin(/.*)?"
sudo restorecon -Rv /opt/wildfly/bin/
sudo systemctl start wildfly
sudo systemctl enable wildfly
systemctl status wildfly
sleep 2

### Прослушаем порт 8080
echo "Прослушаем порт 8080"
sudo ss -tunelp | grep 8080
