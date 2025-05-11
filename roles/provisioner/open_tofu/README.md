# OpenTofu Provisioner Role

The `provisioner/open_tofu` role is designed to manage the provisioning and deprovisioning of infrastructure using OpenTofu. It provides tasks for preparing the environment, executing OpenTofu plans, and managing remote project directories.

## Features

- **Environment Preparation**: Installs OpenTofu and sets up the required environment.
- **Remote Execution Support**: Allows running OpenTofu plans on remote hosts.
- **Dynamic Project Management**: Supports uploading local project directories to remote hosts or using existing remote projects.
- **Provisioning and Deprovisioning**: Handles infrastructure lifecycle management with OpenTofu.

## Role Variables

### Required Variables

- `cifmw_tofu_project_path`: Path to the OpenTofu project containing the `main.tf` file.
- `cifmw_tofu_plan_state`: Desired state of the infrastructure. Options:
  - `present`: Provision the infrastructure.
  - `absent`: Deprovision the infrastructure.

### Optional Variables

- `cifmw_tofu_hosts_pattern`: Ansible hosts pattern for targeting specific hosts. Default: `localhost`.
- `cifmw_tofu_check_mode`: Boolean flag to check the OpenTofu plan without applying it. Default: `false`.
- `cifmw_tofu_use_remote_project`: Boolean flag to use an existing remote project instead of uploading a local one. Default: `false`.
- `cifmw_tofu_remote_execution`: Boolean flag indicating if the role is executed remotely. Default: `false`.
- `cifmw_tofu_dir_path`: Directory path for storing the project on the remote host. Default: `/tmp/tofu`.
- `cifmw_tofu_plan_variables`: Dictionary of variables to pass to the OpenTofu plan.
- `cifmw_tofu_plan_variables_files`: List of files containing variables for the OpenTofu plan.
- `cifmw_tofu_backend_config`: Dictionary of backend configuration for OpenTofu.
- `cifmw_tofu_backend_config_files`: List of files containing backend configuration for OpenTofu.

## Tasks Overview

### Main Tasks

1. **Validation**:
   - Ensures required variables are defined and valid.
   - Fails if `cifmw_tofu_plan_state` or `cifmw_tofu_check_mode` is invalid.

2. **Remote Preparation**:
   - Creates the project directory on the remote host.
   - Copies the local project directory to the remote host (if `cifmw_tofu_use_remote_project` is `false`).

3. **Environment Preparation**:
   - Adds the OpenTofu repository.
   - Installs the OpenTofu binary.
   - Verifies the OpenTofu binary path.

4. **Plan Execution**:
   - Executes the OpenTofu plan with the specified state (`present` or `absent`).
   - Supports passing variables, variable files, backend configuration, and backend configuration files.

5. **Error Handling**:
   - Provides debug messages in case of plan execution failure.

6. **Summary**:
   - Outputs a summary of the OpenTofu execution, including errors and output logs.

## Example Usage

### Playbook Example

```yaml
- name: Provision Infrastructure with OpenTofu
  hosts: localhost
  vars:
    cifmw_tofu_project_path: /path/to/project
    cifmw_tofu_plan_state: present
    cifmw_tofu_check_mode: false
  roles:
    - role: provisioner/open_tofu
```

### Variables Example

```yaml
cifmw_tofu_project_path: /home/user/tofu_project
cifmw_tofu_plan_state: present
cifmw_tofu_check_mode: true
cifmw_tofu_plan_variables:
  var1: value1
  var2: value2
cifmw_tofu_backend_config:
  key: value
```

## Notes

- Ensure the OpenTofu project directory contains a valid `main.tf` file.
- The role requires the `community.general` collection for the `terraform` module.
- For remote execution, ensure the target host has the necessary permissions and connectivity.

## License

This role is licensed under the Apache License, Version 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) file for details.
