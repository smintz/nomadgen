# nomadgen

Still under development.


Contribute:

 # Clone the repo
 # Install the thrift compiler
  sudo apt-get install thrift-compiler
 # Install requirements
  sudo pip install -r requirements.txt
 # Build and install locally
  make
 # Run the examples/hashiapp.py to validate output
  VAULT_TOKEN="<a vault token>" python examples/hashiapp.py
 # Run examples/hashiapp.py against nomad agent to run it
  VAULT_TOKEN="<a vault token>" python examples/hashiapp.py --run


License: MIT
