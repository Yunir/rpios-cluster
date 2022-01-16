# microsd-preparation

### how-to

- define your microsd with `lsblk`
- execute playbook setting `microsd_name`

```
$ ansible-playbook -K -e "microsd_name=sdX" microsd-preparation.yaml
```
