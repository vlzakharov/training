#!/bin/sh
#Установка обновлений
clear
echo Устанавливаем обновления
sleep 1
sudo apt update

#Установка nginx сервера
clear
echo Устанавливаем nginx сервер
sleep 1
sudo apt install nginx

#Запуск nginx сервера на виртуальной машине
clear
echo Запуск nginx сервера на виртуальной машине
sleep 1
sudo systemctl start nginx

#Проверяем работоспособность в виртуальной машине
clear
echo Проверка работоспособности
sleep 1
systemctl status nginx.service
