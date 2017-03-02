# nomadgen

Still under development.


Contribute:

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
