# Role: `test_tso_iperf3_same_host_geneve`

The `test_tso_iperf3_same_host_geneve` role tests `iperf3` performance with and without TSO on the same host using Geneve tunneling.

## Features

- **Geneve Tunneling**:
  - Configures Geneve tunnels for the test environment.

- **TSO Testing**:
  - Runs `iperf3` tests with TSO enabled and disabled.

- **Abstract Role Usage**:
  - Extends the `test_skel/tso_abstract` role for shared logic.

## Variables

- `iperf3_srever`: The hostname of the `iperf3` server.
- `iperf3_clients_group`: The Ansible group containing the `iperf3` clients.
- `iperf3_server_ip`: The IP address of the `iperf3` server.

## Example Usage

```yaml
- name: Run TSO test with Geneve tunneling
  hosts: localhost
  roles:
    - role: test_tso_iperf3_same_host_geneve
```

## Notes

- Ensure Geneve tunneling is supported in the test environment.
- The role depends on the `test_skel/tso_abstract` role.
