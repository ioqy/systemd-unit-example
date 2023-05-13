# 1. Paths
For system units, managed by the root user, use the directory `/etc/systemd/system`.

For user managed units use the directory `~/.config/systemd/user`.

Units that come from installed packages normally use the directory `/usr/lib/systemd/system`.

# 2. Override an existing unit
To override existing preconfigured units use the command `systemctl edit <unit>` or add the file `/etc/systemd/system/<unit>/override.conf` with the changed options.

# 3. The service manager `systemctl`

## User-Mode

To run the service manager (`systemctl`) in user-mode for user managed units in the `~/.config/systemd/user` directory, add the `--user` parameter to every execution like this:

```bash
systemctl status --user <unit>
```

## Reload new or changed unit files

After adding or changing a unit file reload the changes with:

```bash
systemctl daemon-reload
```

## Frequently used Commands

Start a unit:

```bash
systemctl start <unit>
```

Stop a unit:

```bash
systemctl stop <unit>
```

Restart a unit:

```bash
systemctl restart <unit>
```

Asks a unit listed on the command line to reload it's configuration (for the example case of Apache, this will reload Apache's httpd.conf in the web server, not the apache.service systemd unit file):

```bash
systemctl reload <unit>
```

Enable a unit (add to autostart):

```bash
systemctl enable <unit>
```

Install a unit (create symlinks from `[Install]` section for auto start) and start it afterwards:

```bash
systemctl enable --now <unit>
```

Disable a unit (remove symlinks made with `enable`) and stop it afterwards:

```bash
systemctl disable --now <unit>
```

Display status of a unit:

```bash
systemctl restart <unit>
```

Mask a unit to make it impossible to start:

```bash
systemctl mask <unit>
```

Unmask a unit:

```bash
systemctl unmask <unit>
```

Undo all changes made to a unit file with `edit` or `mask`:

```bash
systemctl revert <unit>
```

List all timers:

```bash
systemctl list-timers [--all]
```

# 4. Show log of a unit

System units:

```bash
journalctl --unit <unit>
```

User units:

```bash
journalctl --user-unit <unit>
```

# 5. Usefull systemd tools

Syntax check of unit file:

```bash
systemd-analyze verify [--user] <unit>
```

Escape strings for usage in systemd mount unit names:

```bash
systemd-escape mnt/example
```

Calculate the next 10 elapses of a calendar expression for a timer:

```bash
systemd-analyze calendar --iterations=10 <expression>
```

# 6. Examples

## Add a new service

1. Create the unit file

    - Either with `systemctl`

    ```bash
    systemctl edit --user --force --full example.service
    ```

    - or by creating the unit file manually and then reloading the daemon
    
    ```bash
    systemctl daemon-reload --user
    ```

2. Install the service and start it

    ```bash
    systemctl enable --user --now example.service
    ```

3. Check the status to see if the service is running

    ```bash
    systemctl status --user example.service
    ```

## Remove a service

1. Remove all drop in files

    ```bash
    systemctl revert --user example.service
    ```

2. Uninstall the service and stop it

    ```bash
    systemctl disable --user --now example.service
    ```

3. Delete the unit file

    ```bash
    rm "$(systemctl show --user -P FragmentPath test.service)"
    ```

4. Reload the daemon

    ```bash
    systemctl daemon-reload --user
    ```

5. Reset a possible "failed" state

    ```bash
    systemctl reset-failed --user example.service
    ```

# 7. Man pages

[systemd.unit](https://manpages.debian.org/systemd.unit)  
[systemd.mount](https://manpages.debian.org/systemd.mount)  
[systemd.automount](https://manpages.debian.org/systemd.automount)  
[systemd.path](https://manpages.debian.org/systemd.path)  
[systemd.service](https://manpages.debian.org/systemd.service)  
[systemd.timer](https://manpages.debian.org/systemd.timer)

[systemctl](https://manpages.debian.org/systemctl)

[systemd.time](https://manpages.debian.org/systemd.time)

[systemd-analyze](https://manpages.debian.org/systemd-analyze)
