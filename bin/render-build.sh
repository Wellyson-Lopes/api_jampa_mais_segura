#!/usr/bin/env bash
# bin/render-build.sh

# Instala as dependências Ruby e JavaScript
bundle install
yarn install --check-files

# Limpa assets antigos e pré-compila os novos
bundle exec rails assets:clobber
bundle exec rails assets:precompile

# Executa as migrações do banco de dados
bundle exec rails db:migrate
