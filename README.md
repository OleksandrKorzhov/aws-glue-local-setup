# Usage

To start a development environment just one docker compose service must be run.

Just file is used to simplify commands run but all the commands from there can be modified and run directly via system shell.

## Prerequisites

The following tools must installed on the development machine

- Docker;
- just (preferably but not required);

All the docker setup sits within the `docker-compose.yaml` file. The setup will do the following:

- Create a bind-mount volume to `~/.aws` so AWS credentials are shared between the system and the container;
- Create a bind-mount volume to the current working directory so all the file changes are shared bi-directionally;
- Create a bind-mount volume as required by default Jupyter setup;

## Docker compose services

- `etl_job` - `just start_etl_job`. This command is for advanced/semi-final development. Runs the `main.py` script by passing it to spark-submit (the same what AWS Glue does);
- `jupyter_notebook` - `just start_jupyter`. This command is for general development / quick prototyping. Runs jupyter notebook with jupyter_workspace as a working directory;
- `jupyter_lab` - `just start_jupyter_lab`. This command is for general development. Run jupyter lab that in its turn allows to run different tools and shells;

## Additional commands

- `just start_glue_container` - starts a glue container with PySpark RHEL it allows to prototyping and connecting to the container;
- `connect_to_glue_container` - connect to the previously started PySpark RHEL container;

## Additional info

### AWS CLI

Inside the Glue container AWS CLI v1 is installed therefore functions as `aws sso login` do not work.
To workaround the issue environment variables with AWS access keys can be passed to the container.

Passing env variables with AWS leys to the container:

1. Put env variables to `.env.aws-credentials`;
2. Uncomment the `env_file` config parameter in `docker-compose.yaml`;

### Running commands in container

Glue allows to start processes by passing them as an `command` to a container.

Though if some not prescribed process is run container throws an error `cannot run a binary file`. To workaround the issue the approaches below can be used.

#### Run process from within the container

1. Start a container with PySpark RHEL (it is necessary to make container live long enough) - `just start_glue_container`;
2. Connect to the container and open a Shell within it - `just connect_to_glue_container`;
3. Run the desired process like `python`/`python3`;

#### Use a bash script as a command

1. Create a bash script like `start_jupyter_notebook.sh`;
2. Specify the script as `command` for a container;
3. Run the container;

### Jupyter Lab

By default, Jupyter Lab requires `./jupyter_workspace` folder to exist locally. But it can be configured to any setup.
To reliably start jupyter in the container a bash script must be created that will run jupyter and used as the container `command`.
