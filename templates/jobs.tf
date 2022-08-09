resource "aws_glue_job" "glue_job_{{inputs.job_name}}" {
    name            = "{{inputs.job_name}}"
    role_arn        = "{{inputs.role_arn}}"
    connections     = ["{{inputs.connections}}"]
    timeout         = {{inputs.timeout}}
    glue_version    = "{{inputs.glue_version}}"
    max_retries     = {{inputs.max_retries}}
    {% if inputs.job_type == 'pythonshell' %}
    max_capacity = {{inputs.max_capacity}}
    {% endif %}
    {% if inputs.job_type == 'glueetl' %}
    worker_type         = "{{inputs.worker_type}}"
    number_of_workers   = {{inputs.number_of_workers}}
    {% endif %}

    execution_property {
        max_concurrent_runs = {{inputs.concurrent_runs}}
    }

    command {
        name                = "{{inputs.job_type}}"
        script_location     = "{{inputs.script_location}}"
        python_version      = "3"
    }

    default_arguments {
        {% if inputs.job_type == 'glueetl' and inputs.glue_version == '3.0' %}
        "--enable-auto-scaling"    = true
        {% endif %}
        {% if inputs.extra_py_files == true %}
        "--extra-py-files"         = "{{inputs.extra_py_files_path}}"
        {% endif %}
        {% if inputs.extra_jars == true %}
        "--extra-jars"             = "{{inputs.extra_jars_path}}"
        {% endif %}
        # Inserir parâmetros do jobs aqui
    }
}