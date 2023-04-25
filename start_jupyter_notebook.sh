#!/bin/bash
# source /home/glue_user/.bashrc

jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --ServerApp.root_dir=/home/glue_user/workspace/jupyter_workspace/ --ServerApp.token='' --ServerApp.password=''
