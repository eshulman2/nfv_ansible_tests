# Role: `test_runner`

The `test_runner` role is responsible for orchestrating the execution of tests, managing test workloads, and collecting results. It integrates with other roles to provision infrastructure, run tests, and clean up resources.

## Features

- **Dynamic Test Execution**:
  - Executes tests dynamically based on the `test_name` variable.
  - Supports running tests defined in separate roles.

- **Workload Provisioning**:
  - Provisions and deprovisions test workloads using the `provisioner/open_tofu` role.

- **Result Management**:
  - Collects and stores test results, including pass/fail status and additional information.
  - Handles failures gracefully and records failure reasons.

## Role Variables

### Required Variables

- `test_name`: The name of the test to be executed. This corresponds to a role under the `roles/tests` directory.

### Optional Variables

- `tofu_dir` (default: `../roles/tests/{{ test_name }}/tofu_files/`): Path to the directory containing test-specific files.
- `test_failure_reason` (default: `"Not set yet"`): Reason for test failure, set dynamically during execution.
- `test_additional_info` (default: `"none"`): Additional information about the test, set dynamically during execution.

### Internal Variables

- `results`: A dictionary to store the results of the test.
- `failures`: A counter for the number of failed tests.
- `errors`: A counter for the number of tests that encountered errors.
- `skipped`: A counter for the number of skipped tests.

## Tasks Overview

1. **Check for Test Files**:
   - Verifies the existence of test-specific files in the `tofu_dir` directory.

2. **Provision Test Workload**:
   - Uses the `provisioner/open_tofu` role to provision the required infrastructure for the test.

3. **Dynamic Inventory**:
   - Dynamically adds hosts to the Ansible inventory using the `common/dynamic_inventory` role.

4. **Run Test**:
   - Includes the test role specified by the `test_name` variable.

5. **Handle Test Results**:
   - Records the test status (passed/failed) and additional information.
   - Handles failures by recording failure reasons and updating the results dictionary.

6. **Clean Up**:
   - Deprovisions the test workload using the `provisioner/open_tofu` role.

## Example Usage

### Playbook Example

```yaml
- name: Run a specific test
  hosts: localhost
  vars:
    test_name: test_tso_iperf3_same_host
  roles:
    - role: test_runner
```

### Variables Example

```yaml
test_name: test_tso_iperf3_same_host
tofu_dir: ../roles/tests/test_tso_iperf3_same_host/tofu_files/
```

## Output

The role updates the `results` dictionary with the following structure:

```yaml
results:
  <test_name>:
    status: <passed|failed>
    additional_info: <additional information>
    failure_reason: <reason for failure> # Only present if the test failed
```

### Example Output

```yaml
results:
  test_tso_iperf3_same_host:
    status: passed
    additional_info: "Test completed successfully."
```

## Notes

- Ensure the `test_name` corresponds to a valid role under the `roles/tests` directory.
- The `provisioner/open_tofu` role must be properly configured to handle workload provisioning.
- The `common/dynamic_inventory` role is used to dynamically manage test hosts.
- Test results are stored in the `results` dictionary, which can be used for further processing or reporting.

## License

This role is licensed under the Apache License, Version 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) file for details.
