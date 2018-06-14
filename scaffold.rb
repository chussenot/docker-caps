# In a docker container with privileged mode how can find the listed caps:

caps= %w{cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid
cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable
cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw
cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot
cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice
cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease
cap_audit_write cap_audit_control cap_setfcap cap_mac_override
cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read+eip}

`mkdir -p tests`
caps.each do |cap|
  File.open("tests/#{cap}.yml", 'w') { |file| file.write("gossfile:\n   os_version.yaml: {}") }
  `mkdir -p tests/#{cap}`
  File.open("tests/#{cap}/os_version.yml", 'w') do |file|
    os_version=<<-os_version
command:
  "cat /proc/version":
    exit-status: 0
    timeout: 120000
    os_version
    file.write(os_version)
  end
end
