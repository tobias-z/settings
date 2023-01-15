# settings

The settings for my personal desktop

## About

Using this will let ansible install and setup the whole computer. You can create users and define what kind of applications that should be installed in the `user-settings.yaml` file

After running the script ones, it will setup a cron job for the `automation` user, which will automatically track if there has been changes to the repository and rerun if there has.

## Requirements

- Debian
- A configuration with the same name as your local user in the `user-settings.yaml` file.

## Usage

You can use this repository, but I would recommend forking it and changing it to match your URL both when running it initially, but also in the `rerun_ansible.yaml` file.

```bash
sudo ansible-pull -U https://github.com/tobias-z/settings -e "the_user=tobiasz github_token=someToken"
```