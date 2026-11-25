#!/bin/sh
set -eu

pip install uv
pip install --upgrade flyte
flyte create config --devbox --force

echo " flyte start devbox"
