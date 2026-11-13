#!/usr/bin/env bash

usn=$USER

echo -e """
[terminal]
vt = \"1\"

[default_session]
command = \"mango\"
user = \"${usn}\" 
""" | sudo tee /etc/greetd/config.toml && systemctl enable --now greetd.service
