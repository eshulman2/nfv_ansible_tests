# Role: `test_tso_iperf3_different_host`

The `test_tso_iperf3_different_host` role tests `iperf3` performance with and without TSO across different hosts.

## Features

- **Cross-Host Testing**:
  - Runs `iperf3` tests between two separate hosts.

- **TSO Validation**:
  - Compares performance metrics with TSO enabled and disabled.

- **Dynamic Inventory**:
  - Dynamically configures test instances.

## Variables

- `iperf3_srever`: The hostname of the `iperf3` server.
- `iperf3_clients_group`: The Ansible group containing the `iperf3` clients.
- `iperf3_server_ip`: The IP address of the `iperf3` server.

## Example Usage

```yaml
- name: Run TSO test across different hosts
  hosts: localhost
  roles:
    - role: test_tso_iperf3_different_host
```

## Notes

- Ensure the test environment is provisioned with anti-affinity rules.
- The role uses the `test_skel/tso_abstract` role for shared logic.
