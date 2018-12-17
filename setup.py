from distutils.core import setup

VERSION = "0.1.0"
setup(
    name="nomadgen",
    packages=["nomadgen", "nomadgen.jobspec", "nomadgen.api"],
    version=VERSION,
    description="Configuration util in python syntax for Hashicorp's Nomad",
    license="MIT",
    author="Shahar Mintz",
    author_email="shahar.mintz309@gmail.com",
    url="https://github.com/smintz/nomadgen",
    download_url="https://github.com/smintz/nomadgen/archive/" "%s.tar.gz" % VERSION,
    keywords=["nomad", "hcl", "hashicorp"],
    classifiers=[],
    requires=["requests", "thrift"],
)
