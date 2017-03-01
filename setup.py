from distutils.core import setup
VERSION='0.0.1'
setup(
    name = 'nomadgen',
    packages = ['nomad', 'nomad/jobspec'],
    version = VERSION,
    description = "Configuration util in python syntax for Hashicorp's Nomad",
    license = 'MIT',
    author = 'Shahar Mintz',
    author_email = 'shahar.mintz309@gmail.com',
    url = 'https://github.com/smintz/nomadgen',
    download_url = 'https://github.com/smintz/nomadgen/archive/%s.tar.gz' % VERSION,
    keywords = ['nomad', 'hcl', 'hashicorp'],
    classifiers = [],
)