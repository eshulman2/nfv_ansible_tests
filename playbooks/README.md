# Ansible Playbook: `run_test.yaml`

## Overview

The `run_test.yaml` playbook is designed to execute a series of tests on a specified target host or localhost by default. It collects the results of the tests, writes them to a file, and optionally prints them to the console.

## Variables

- `testing_target` (default: `localhost`): The target host where the tests will be executed.
- `tests`: A list of test names to be executed. Each test corresponds to a role that will be included dynamically.
- `test_name`: The name of the current test being executed (used internally during the loop).
- `results`: A dictionary to store the results of the tests.
- `failures`: A counter for the number of failed tests (default: `0`).
- `errors`: A counter for the number of tests that encountered errors (default: `0`).
- `skipped`: A counter for the number of skipped tests (default: `0`).

## Tasks

1. **Run Tests**:
   - Includes the `test_runner` role for each test in the `tests` list.
   - Passes the `test_name` variable to the role.

2. **Write Results to File**:
   - Writes the `results` dictionary to a YAML file located at `/var/lib/AnsibleTests/external_files/results.yaml`.

3. **Print Results**:
   - Outputs the `results` dictionary in a human-readable YAML format to the console.

4. **(TBD) Generate JUnitXML File**:
   - This task is currently commented out. If enabled, it would use the `junitxml` role to generate a JUnitXML file based on the results.

## Usage

Run the playbook with the following command:

```bash
ansible-playbook run_test.yaml -e "testing_target=<target_host> tests=<test_list>"
```

- Replace `<target_host>` with the desired target host (optional, defaults to `localhost`).
- Replace `<test_list>` with a comma-separated list of test names.

### Example

```bash
ansible-playbook run_test.yaml -e "testing_target=192.168.1.10 tests=['test1', 'test2', 'test3']"
```

This command will execute `test1`, `test2`, and `test3` on the host `192.168.1.10`.

## Notes

- Ensure the `test_runner` role is properly configured to handle the tests.
- The results file will be saved at `/var/lib/AnsibleTests/external_files/results.yaml`. Ensure the directory exists and is writable.
- Uncomment the JUnitXML task if you need to generate a JUnitXML report.
