# microsd-preparation

### how-to

- define your microsd with `lsblk`
- execute playbook setting `microsd_name`

```
$ ansible-playbook -Ke "microsd_name=sdX host_id=9" microsd-preparation.yaml
```

# develop

- execute tasks via ad-hoc cli tool

```
$ ansible [-Kb] --connection=local 127.0.0.1 -m MODULE -a "opt1=1 opt2=2"
```
