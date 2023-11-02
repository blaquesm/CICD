## Part 1. Настройка gitlab-runner  
#### Поднимаем виртуальную машину  
![Part.1.1.png](scrin/1.png)  

#### Скачиваем и устанавливаем gitlab-runner  
![Part.1.2.png](scrin/2.png)  
Получив ошибку 0000, переустаналиваем gitlab-runner с использованием команд:  
`sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"`

`sudo chmod +x /usr/local/bin/gitlab-runner`

`sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash`

`sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner`

`sudo gitlab-runner start`

`sudo systemctl enable --now gitlab-runner`

#### Регистрируем gitlab-runner  
![Part.1.3.png](scrin/3.png)  

## Part 2. Сборка  

#### Создаём файл `.gitlab-ci.yml` в корне проекта и вписываем туда следующее:  

![Part.2.1.png](scrin/4.png)  

#### Добавим `s21_cat` и `s21_grep` из проекта `SimpleBash`, пушим и проверяем работу:  

![Part.2.2.png](scrin/5.png)  

## Part 3. Тест кодстайла  
#### Дополняем `.gitlab-ci.yml` 
#### Кодстайла:  
![Part.3.2.png](scrin/3/1.png)  
![Part.3.2.png](scrin/3/2.png)  
#### Пушим, проверяем:  

![Part.3.3.png](scrin/3/3.png)  

#### Проверим, как отработает с ошибкой:  

![Part.3.4.png](scrin/3/4.png)  

#### Пайплайн:  

![Part.3.5.png](scrin/3/5.png)  

Работае корректно.  

## Part 4. Интеграционные тесты  
#### Добавим этап в начало `.gitlab-ci.yml`  
![Part.4.1.png](scrin/4/1.png)  

#### Допишем стадию:  
![Part.4.2.png](scrin/4/2.png)  

#### Пушим, смотрим результат:  
![Part.4.3.png](scrin/4/3.png)

#### Проверим реакции на ошибки, для этого немного сламаем cat
![Part.4.4.png](scrin/4/4.png)

#### Пайплайн успешно зафейлен:

![Part.4.5.png](scrin/4/5.png)

#### Завершает этап проверки FAIL на style
![Part.4.6.png](scrin/4/6.png)

## Part 5. Этап деплоя

#### Запустим вторую машину 
![Part.5.1.png](scrin/5/1.png)

#### Редактируем файл /etc/netplan/00-installer-config.yaml на машинах:
![Part.5.2.png](scrin/5/2.png)

#### Настраиваем адаптеры:
![Part.5.3.png](scrin/5/3.png)

#### Пропингуем машины
![Part.5.4.png](scrin/5/4.png)

 #### Дополним этапы стапией деплой 
 ![Part.5.5.png](scrin/5/5.png)

#### Ее содержание 
![Part.5.6.png](scrin/5/6.png)

#### deploy.sh содержит следующие команды 
![Part.5.7.png](scrin/5/7.png)

 #### Пользователю gitlab-runner зададим пароль `sudo passwd gitlab-runner`

 #### После зададим параметр для выполнения sudo без запроса пароля `sudo visudo`
 ![Part.5.8.png](scrin/5/8.png)

 #### Сгенерируем ssh ключ командой ssh-keygen и скопируем его на вторую машину командой `ssh-copy-id blaq@10.10.0.2`

#### Проверим подключение 
![Part.5.9.png](scrin/5/9.png)cd

#### Зададим на машинах права для папки /usr/local/bin/ командой `sudo chmod -R 777 /usr/local/bin`

#### После пуша 4я стадия ждет ручного запуска 
![Part.5.10.png](scrin/5/10.png)

#### Этап пройден успешно. Файлы в назначенном месте 
![Part.5.11.png](scrin/5/11.png)

## Part 6. Дополнительно. Уведомления

#### Создаем бота используя @botfather
![Part.6.1.png](scrin/6/1.png)

#### Добавим вызов скрипта notify.sh после каждой стадии:
![Part.6.2.png](scrin/6/2.png)

#### Скрипт notify.sh
![Part.6.3.png](scrin/6/3.png)

#### Проверим бота после пуша
![Part.6.4.png](scrin/6/4.png)
