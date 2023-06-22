#!/bin/zsh
set -e

rake 'db:migrate'

exec "$@"