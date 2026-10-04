#!/usr/bin/env bash
set -euo pipefail

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
err() { echo -e "${RED}[!]${NC} $1"; }

check_os() {
    if ! grep -qi ubuntu /etc/os-release; then
        err "Этот скрипт поддерживает только Ubuntu"
        exit 1
    fi
    log "OS: Ubuntu"
}

install_package() {
    local pkg="$1"
    if dpkg -l | grep -q "^ii  $pkg"; then
        log "$pkg уже установлен"
    else
        log "Устанавливаю $pkg..."
        sudo apt install -y "$pkg"
    fi
}

check_versions() {
    log "Проверка версий:"
    for cmd in git python3 uv docker; do
        if command -v "$cmd" &>/dev/null; then
            echo "  $cmd: $($cmd --version 2>&1 | head -n1)"
        else
            echo "  $cmd: не установлен"
        fi
    done
}

main() {
    check_os
    log "Обновление пакетов..."
    sudo apt update
    install_package git
    install_package python3
    install_package tmux
    # uv устанавливается отдельно, не через apt
    if ! command -v uv &>/dev/null; then
        log "Устанавливаю uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    else
        log "uv уже установлен"
    fi
    check_versions
    log "Готово"
}

main "$@"
