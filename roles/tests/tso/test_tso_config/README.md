# Role: `test_tso_config`

The `test_tso_config` role validates that TSO (TCP Segmentation Offload) is enabled in the Open vSwitch (OVS) configuration.

## Features

- **TSO Configuration Check**:
  - Verifies that TSO is enabled in the OVS configuration.

- **Failure Handling**:
  - Fails the test if TSO is not enabled.

## Variables

- None specific to this role.

## Example Usage

```yaml
- name: Validate TSO configuration
  hosts: localhost
  roles:
    - role: test_tso_config
```

## Notes

- Ensure Open vSwitch is installed and configured on the target host.
- The role assumes the target host is accessible via Ansible.
