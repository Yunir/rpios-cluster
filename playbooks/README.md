# microsd-preparation

### how-to

- define your microsd with `lsblk`
- execute playbook setting `microsd_name`

```
$ ansible-playbook -Ke "microsd_name=sdX host_id=9" microsd-preparation.yaml
```
