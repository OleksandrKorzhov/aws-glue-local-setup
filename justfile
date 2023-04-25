start_glue_container:
    #!/usr/bin/env bash
    echo "Starting a Glue container in the background"
    echo "Container exposes ports 4040 and 18080"
    echo "Current working directory is mapped to /home/glue_user/workspace"
    echo "AWS config (~/.aws/config) is mapped to /home/glue_user/.aws"

    docker run --name glue_spark \
      --rm \
      -it \
      -v ~/.aws:/home/glue_user/.aws \
      -v $(pwd):/home/glue_user/workspace \
      -e AWS_PROFILE=sandbox \
      -e DISABLE_SSL=true \
      -p 4040:4040 \
      -p 18080:18080 \
      amazon/aws-glue-libs:glue_libs_3.0.0_image_01 pyspark

connect_to_glue_container:
    #!/usr/bin/env bash
    echo "Connecting to glue_spark container"
    docker exec -it --workdir /home/glue_user/workspace glue_spark bash

start_etl_job:
    #!/usr/bin/env bash
    docker compose up etl_job

start_jupyter_lab:
    docker compose up jupyter_lab

connect_to_jupyter_lab:
    docker compose exec jupyter_lab bash

start_jupyter:
    docker compose up jupyter_notebook