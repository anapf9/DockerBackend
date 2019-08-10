# DockerBackend
PHP, MYSQL NGINX

# Configurações Iniciais
Para instalar o composer globalmente:
```
cd ~
git clone https://github.com/laravel/laravel.git laravel-app
cd ~/laravel-app
docker run --rm -v $(pwd):/app composer install
```
No **Dockerfile**:
Coloque o nome da pasta que você escolheu para seu projeto laravel:
    # Copy composer.lock and composer.json
    COPY composer.lock composer.json /var/www/(nome da pasta)

    # Set working directory
    WORKDIR /var/www/(nome da pasta)
    
No **docker-compose.yml**:
Escolha o nome, senha e versão do seu banco de dados.

No **terminal** digite: 
```
docker-compose build && docker-compose up -d
```
# Para usar o mesmo container com outros projetos
1. No Kitematic
    Em "app" e "webserver": Ir em Settings->Volumes e trocar o LOCAL FOLDER para a pasta com o novo projeto
    Em "db": modifique o nome do banco de dados e a senha
1. Certifique-se de que o .env esteja com os nomes corretos:
    ```nano .env```
    DB_CONNECTION=mysql
    DB_HOST=db
    DB_PORT=3306
    DB_DATABASE=teste
    DB_USERNAME=root
    DB_PASSWORD=root
1. Na pasta do seu projeto laravel, adicionar no ../AppServiceProvider:
use Illuminate\Support\Facades\Schema;
Schema::defaultStringLength(191); //NEW: Increase StringLength
1. Na pasta onde esta o arquivo docker-file.yml entre nos container usando:
    ```docker exec -itu root -w / app bash```
1. Certifique-se de ir ao caminho correto:
    ```cd var/www/(nome_da_nova_pasta)```
1. use os comandos:
    ```php artisan cache:clear
    php artisan config:cache
    ```
1.  Se houver a mensagem do composer como root instale ou atualize as dependencias com os comandos
    ```composer install --no-plugins --no-scripts ...
    composer update --no-plugins --no-scripts ...
    ```
1. Faça a migration:
    ```php artisan migrate```
1. Para o front do quasar:
  https://medium.com/@jwdobken/develop-quasar-applications-with-docker-a19c38d4a6ac
1. Para problemas na hora de salvar o arquivo:
  ```sudo chown -hR meuusuario minhapasta/``` da a permissão para o meu usuário alterar a pasta que quero
