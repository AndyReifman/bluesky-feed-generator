#!/bin/bash -e

THIS_DIR=`dirname $0`
VENV_LOCATION=$THIS_DIR/.venv

if [x"${VENV_LOCATION}" = xnull ] || [ x"${VENV_LOCATION}" = x"" ]; then
  VENV_LOCATION=$THIS_DIR/.venv
fi

PYTHON_EXECUTABLE='python3.11'

install_python(){
    echo "Installing Python virtual environment to $VENV_LOCATION"
    [ -d "$VENV_LOCATION" ] && echo "Remove previous Python's env: $VENV_LOCATION" && rm -rf $VENV_LOCATION
    PY_LOCATION=$(which ${PYTHON_EXECUTABLE})
    $PY_LOCATION -m venv $VENV_LOCATION
}

check_poetry() {
    echo "Verifying Poetry installation"
    if command -v poetry &> /dev/null ; then
      echo "Poetry installed"
    else
      echo "ERROR: Poetry not installed. Please install  it."
      exit 1
    fi
}

install_packages() {
    echo "Installing dependency packages"
    source activate
    pip install pip\>=20.3.4
    poetry install --with-dev
    echo $(pip list)
    deactivate
}

cd $THIS_DIR
install_python && check_poetry && install_packages