# nomadgen

Craft your [Hashicorp's Nomad](https://nomadproject.io) job specs in python.

Still under development.

### Motivation

Nomad is a great job/task scheduler but HCL is pretty limited. This tool will allow you to easily create job specs in python. Its heavily inspired by Facebook's [configerator](http://muratbuffalo.blogspot.co.il/2016/02/holistic-configuration-management-at.html).

### Install and run
 1. `pip install nomadgen`
 2. See JSON output: `python jobspec.py`
 3. Apply to Nomad: `python jobspec.py --run`

### Examples

 * [Redis](https://github.com/smintz/nomadgen/blob/master/examples/redis.py) - See how to use same basic task spec config with different drivers (Docker, rkt, qemu).
 * [Hashiapp](https://github.com/smintz/nomadgen/blob/master/examples/hashiapp.py) - Blue/Green deployments made easy.
 * [periodic](https://github.com/smintz/nomadgen/blob/master/examples/periodic.py) - Periodic task example.
 * [common/resources](https://github.com/smintz/nomadgen/blob/master/examples/common/resources.py) - How to simplfy your API even better.

## Contribute:

 1. Clone the repo
 1. Install the thrift compiler
```
sudo apt-get install thrift-compiler
```
 1. Install requirements
```
  sudo pip install -r requirements.txt
```
 1. Build and install locally
```
  make
```
 1. Run the examples/hashiapp.py to validate output
```
  VAULT_TOKEN="<a vault token>" python examples/hashiapp.py
```
 1. Run examples/hashiapp.py against nomad agent to run it
```
  VAULT_TOKEN="<a vault token>" python examples/hashiapp.py --run
```

License: MIT
