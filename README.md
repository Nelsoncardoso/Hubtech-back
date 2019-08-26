* ## Teste Hubtec - Sistema para criação de tarefas (Backend)

  #####  System dependencies

  - Docker (<https://www.docker.com/>)
  - Docker-compose

  #####  Plataformas
  
  - Ruby on Rails

  #####  Instalação e Utilização

  Backend

     ```
     cd Hubtech-back
     
     docker-compose run --rm app bundle install
     
     docker-compose run --rm app bundle exec rails db:create db:migrate db:seed
     
     docker-compose up
     ```
