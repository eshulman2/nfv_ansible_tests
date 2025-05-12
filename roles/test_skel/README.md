# Test Skeleton (`test_skel`)

The `test_skel` directory provides an abstract structure for defining reusable test logic. It is designed to minimize code duplication by allowing tests with similar logic but different parameters to share a common framework.

## Purpose

The primary goal of the `test_skel` directory is to provide a base structure for tests that can be extended or customized for specific scenarios. This approach ensures consistency across tests and reduces the effort required to create new tests with similar functionality.

## Features

- **Reusable Logic**: Encapsulates common test logic in a single location.
- **Parameterization**: Allows tests to be customized by passing different variables.
- **Consistency**: Ensures that all tests follow a standardized structure.
- **Ease of Maintenance**: Centralizes shared logic, making it easier to update or fix issues.

## Structure

The `test_skel` directory contains the following key components:

### 1. **Abstract Roles**
Abstract roles define the core logic of the tests. These roles are included in specific tests and customized using variables.

- Example: `tso_abstract` role provides the logic for running `iperf3` tests with and without TSO (TCP Segmentation Offload).

### 2. **Variables**
Variables are used to parameterize the tests. Each test can override these variables to customize the behavior of the abstract roles.

### 3. **Tasks**
Tasks define the steps required to execute the test. These tasks are designed to be generic and reusable.

### 4. **Documentation**
Documentation is provided to explain how to use the abstract structure and customize it for specific tests.

## Usage

To create a new test using the `test_skel` structure:

1. **Include the Abstract Role**:
   - Use the `ansible.builtin.include_role` module to include the abstract role in your test.

2. **Customize Variables**:
   - Override the variables defined in the abstract role to customize the test behavior.

3. **Add Specific Logic (Optional)**:
   - If needed, add additional tasks or logic specific to your test.

### Example

#### Abstract Role (`tso_abstract`)
The `tso_abstract` role provides the logic for running `iperf3` tests with and without TSO.

#### Specific Test
A specific test can include the `tso_abstract` role and customize it as follows:

```yaml
- name: Include abstract role
  ansible.builtin.include_role:
    name: test_skel/tso_abstract
    public: true
  vars:
    iperf3_server: server_0
    iperf3_clients_group: "test_tso_iperf3_client"
    iperf3_server_ip: "{{ hostvars[iperf3_server]['ansible_eth1']['ipv4']['address'] }}"
```

## Benefits

- **Reduced Code Duplication**: Common logic is written once and reused across multiple tests.
- **Improved Test Coverage**: Makes it easier to create new tests, leading to better coverage.
- **Simplified Maintenance**: Updates to shared logic automatically apply to all tests using the abstract structure.

## Notes

- Ensure that the abstract roles are well-documented to make them easy to use and extend.
- Use meaningful variable names to make the tests self-explanatory.
- Follow the existing structure and conventions to maintain consistency.

## License

This directory is licensed under the Apache License, Version 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) file for details.
