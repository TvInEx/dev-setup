# dev-setup

Скрипт автоматической настройки рабочего окружения для backend-разработки.

## Что устанавливает

- git, python3, uv, docker
- git-хук pre-commit с ruff и black

## Запуск

    bash setup.sh

## Требования

- Ubuntu 22.04+ (или WSL2)
- Права sudo

## Что делает скрипт

1. Проверяет, что ОС — Ubuntu
2. Устанавливает git, python3, tmux
3. Устанавливает uv (если ещё нет)
4. Выводит версии всех инструментов

## Git-хуки

Активация pre-commit хука:

    chmod +x .githooks/pre-commit
    git config core.hooksPath .githooks
