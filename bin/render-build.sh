#!/usr/bin/env bash
# bin/render-build.sh

set -e

# Instala dependências e configurações
bundle install
yarn install --check-files

# Limpa e recompila os assets
RAILS_ENV=production bundle exec rails assets:clobber
RAILS_ENV=production bundle exec rails assets:precompile

# Migrações do banco de dados
bundle exec rails db:migrate
