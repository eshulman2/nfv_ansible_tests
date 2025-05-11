# Role: `common/run_iperf3`

The `common/run_iperf3` role is designed to automate the execution of `iperf3` tests between a server and one or more clients. It supports collecting and parsing the results for performance analysis.

## Features

- **Automated `iperf3` Setup**:
  - Installs `iperf3` on the specified hosts.
  - Configures the server and clients dynamically.

- **Flexible Configuration**:
  - Supports running tests with customizable durations.
  - Allows dynamic inventory integration for flexible host management.

- **Result Parsing**:
  - Collects and parses `iperf3` JSON output.
  - Stores results in a structured dictionary for further analysis.

## Role Variables

### Required Variables

- `iperf3_srever`: The hostname or IP address of the `iperf3` server.
- `iperf3_clients_group`: The Ansible group containing the `iperf3` clients.
- `iperf3_server_ip`: The IP address of the `iperf3` server to which clients will connect.

### Optional Variables

- `iperf3_run_time` (default: `60`): Duration of the `iperf3` test in seconds.
- `iperf_result_dict_name` (default: `<test_name>_iperf_results`): Name of the dictionary to store the parsed results.

## Tasks Overview

1. **Prepare `iperf3` Instances**:
   - Installs `iperf3` on the server and client hosts.

2. **Run `iperf3` Server**:
   - Starts the `iperf3` server in daemon mode on the specified host.

3. **Run `iperf3` Clients**:
   - Executes `iperf3` tests from the clients to the server.
   - Supports asynchronous execution for multiple clients.

4. **Wait for Test Completion**:
   - Ensures the `iperf3` tests complete before proceeding.

5. **Parse and Store Results**:
   - Collects the JSON output from the clients.
   - Parses and stores the results in a structured dictionary.

## Example Usage

### Playbook Example

```yaml
- name: Run iperf3 tests
  hosts: localhost
  vars:
    iperf3_srever: server_0
    iperf3_clients_group: test_clients
    iperf3_server_ip: 192.168.1.10
    iperf3_run_time: 120
  roles:
    - role: common/run_iperf3
```

### Inventory Example

```ini
[servers]
server_0 ansible_host=192.168.1.10

[test_clients]
client_1 ansible_host=192.168.1.11
client_2 ansible_host=192.168.1.12
```

## Output

The role generates a dictionary containing the parsed results of the `iperf3` tests. The structure is as follows:

```yaml
<iperf_result_dict_name>:
  <client_name>:
    <parsed_iperf3_output>
```

### Example Output

```yaml
iperf_results:
  client_1:
    end:
      sum_received:
        bits_per_second: 1000000000
  client_2:
    end:
      sum_received:
        bits_per_second: 950000000
```

## Notes

- Ensure that the `iperf3` binary is available in the package repositories of the target hosts.
- The role assumes that the server and clients are reachable over the network.
- Use the `dynamic_inventory` role to dynamically add hosts to the inventory if needed.

## License

This role is licensed under the Apache License, Version 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) file for details.
