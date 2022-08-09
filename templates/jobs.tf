resource "aws_glue_job" "glue_job_{{inputs.job_name}}" {
    name            = "{{inputs.job_name}}"
    role_arn        = "{{inputs.role_arn}}"
    connections     = ["{{inputs.connections}}"]
    timeout         = {{inputs.timeout}}
    glue_version    = "{{inputs.glue_version}}"
    max_retries     = {{inputs.max_retries}}

    execution_property {
        max_concurrent_runs = {{inputs.concurrent_runs}}
    }

    command {
        name                = "{{inputs.job_type}}"
        script_location     = "{{inputs.script_location}}"
    }

    {% if inputs.job_type == 'pythonshell' %}
    max_capacity = {{inputs.max_capacity}}
    {% endif %}

    {% if inputs.job_type == 'glueetl' %}
    worker_type         = "{{inputs.worker_type}}"
    number_of_workers   = {{inputs.number_of_workers}}
    {% endif %}
}