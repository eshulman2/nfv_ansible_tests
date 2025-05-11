# dynamic_inventory

The `dynamic_inventory` role is responsible for dynamically adding hosts to the Ansible inventory based on a predefined configuration file (`servers.yaml`) and ensuring that the hosts are reachable and properly configured for subsequent tasks.

## Role Structure

- **Tasks File**: [roles/common/dynamic_inventory/tasks/main.yaml](roles/common/dynamic_inventory/tasks/main.yaml)

## Features

1. **Dynamic Inventory Creation**:
   - Reads host configuration from a `servers.yaml` file.
   - Adds hosts to the Ansible inventory dynamically with associated groups, SSH keys, and user information.

2. **Connection Validation**:
   - Waits for the newly added hosts to become reachable using the `wait_for_connection` module.

3. **Fact Collection**:
   - Collects Ansible facts from the newly added hosts to ensure they are ready for further tasks.

## Variables

The following variables are used in this role:

- `tofu_dir`: Path to the directory containing the `servers.yaml` file. Default is defined in the `test_runner` role as `../roles/tests/{{ test_name }}/tofu_files/`.
- `test_name`: Name of the test being executed. Used to group hosts dynamically.

## Input File

The role expects a `servers.yaml` file in the `tofu_dir` directory. The file should define the dynamic instances in the following format:

```yaml
ssh_key: /path/to/private/key
dynamic_instances:
  - name: server_0
    user: cloud-user
    group: test_group
    fip: 192.168.1.10
    vars:
      custom_var: value
  - name: server_1
    user: cloud-user
    group: test_group
    fip: 192.168.1.11
    vars:
      custom_var: value
```

## Tasks in `main.yaml`

1. **Include Dynamic Instances Variables**:
   - Loads the `servers.yaml` file from the `tofu_dir` directory and assigns its contents to the `dynamic_testing_instances` variable.

2. **Add Hosts to Dynamic Inventory**:
   - Iterates over the `dynamic_instances` list from the `servers.yaml` file.
   - Adds each host to the Ansible inventory with its associated group, SSH key, user, and custom variables.

3. **Wait for Connection**:
   - Waits for up to 300 seconds for the newly added hosts to become reachable, starting the checks after a 30-second delay.

4. **Collect Facts**:
   - Gathers Ansible facts from the newly added hosts to ensure they are ready for subsequent tasks.

## Notes

- Ensure the `servers.yaml` file is correctly formatted and located in the specified `tofu_dir` directory.
- The `wait_for_connection` task ensures that the hosts are reachable before proceeding with further tasks.
- The `setup` task collects facts, which are essential for many Ansible operations.