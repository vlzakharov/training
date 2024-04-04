#!/bin/sh -x
#Установка обновлений
clear
echo Устанавливаем обновления
sleep 1
apt-get update

#Установка nginx сервера
clear
echo Устанавливаем nginx сервер
sleep 1
apt-get install -y nginx

#Запуск nginx сервера на виртуальной машине
clear
echo Запуск nginx сервера на виртуальной машине
sleep 1
service nginx start

#Проверяем работоспособность в виртуальной машине
clear
echo Проверка работоспособности
sleep 1
systemctl status nginx.service
