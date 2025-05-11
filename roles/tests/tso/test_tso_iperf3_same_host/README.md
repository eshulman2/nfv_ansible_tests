# Role: `test_tso_iperf3_same_host`

The `test_tso_iperf3_same_host` role is designed to test the performance of `iperf3` with and without TSO (TCP Segmentation Offload) on the same host.

## Features

- **TSO Testing**:
  - Runs `iperf3` tests with TSO enabled and disabled.
  - Compares performance metrics to validate TSO impact.

- **Dynamic Inventory**:
  - Uses dynamic inventory to configure test instances.

- **Reusable Abstract Role**:
  - Leverages the `test_skel/tso_abstract` role for shared logic.

## Variables

- `iperf3_srever`: The hostname of the `iperf3` server.
- `iperf3_clients_group`: The Ansible group containing the `iperf3` clients.
- `iperf3_server_ip`: The IP address of the `iperf3` server.

## Example Usage

```yaml
- name: Run TSO test on the same host
  hosts: localhost
  roles:
    - role: test_tso_iperf3_same_host
```

## Notes

- Ensure the `test_skel/tso_abstract` role is available.
- The role assumes the test environment is provisioned using Terraform.
