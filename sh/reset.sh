#!/bin/bash
# Reset Base de dados
SRC=/home/wiremaze/Documents/TesteNode/
echo "Drop base de dados"
cd $SRC && rake db:drop
echo "Criar base de dados"
cd $SRC && rake db:create
echo "Migrar base de dados"
cd $SRC && rake db:migrate
echo "Seed base de dados"
cd $SRC && rake db:seed

