#!/usr/bin/env bash

set -e

ARGS="$@"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
VENV_PATH="$DIR/venv"

fail() {
    echo "ERROR! $1" >&2
    echo "Aborting..." >&2
    exit 1
}

check_python() {
    command -v /usr/bin/python3 >/dev/null 2>&1 || fail "Python is required but it's not installed."

    PYTHON_VERSION=$(/usr/bin/python3 --version 2>&1 | awk '{print $2}') || fail "Failed to fetch Python version"

    PYTHON_MAJOR_VERSION=$(echo "$PYTHON_VERSION" | cut -d'.' -f1)
    PYTHON_MINOR_VERSION=$(echo "$PYTHON_VERSION" | cut -d'.' -f2)

    if [ "$PYTHON_MAJOR_VERSION" -lt 3 ] || { [ "$PYTHON_MAJOR_VERSION" -eq 3 ] && [ "$PYTHON_MINOR_VERSION" -lt 9 ]; }; then
      fail "Python version 3.9 or higher is required (installed: Python $PYTHON_VERSION)"
    fi
}

setup_venv() {
    command -v /usr/bin/virtualenv >/dev/null 2>&1 || fail "virtualenv is required but it's not installed."

    # Create a virtual environment if it doesn't exist
    if [ ! -d "$VENV_PATH" ]; then
        echo "Creating a virtual environment..."
        /usr/bin/virtualenv "$VENV_PATH"
    fi

    source "$VENV_PATH/bin/activate"

    echo "Installing pip requirements..."
    pip install -r "$DIR/requirements-pip.txt"

}

setup_ansible() {
    # TODO: check that ansible version (ansible --version) matches the one in requirements.txt

    ansible-galaxy collection install -r requirements-ansible.yml
    ansible-galaxy role install -r requirements-ansible.yml
}


check_python
setup_venv
setup_ansible

export ANSIBLE_FORCE_COLOR=1
export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook site.yml -i inventory/ $ARGS
