# Ansible Fabio

Master: [![Build Status](https://travis-ci.org/lobsterdore/ansible-fabio.svg?branch=master)](https://travis-ci.org/lobsterdore/ansible-fabio)
Develop: [![Build Status](https://travis-ci.org/lobsterdore/ansible-fabio.svg?branch=develop)](https://travis-ci.org/lobsterdore/ansible-fabio)

* [To install](#to-install)
* [How to use](#how-to-use)
* [Tags](#tags)
* [Development](#development)
* [Contributing](#contributing)

Installs and configures [Fabio](https://github.com/eBay/fabio).




## To install

This role has been tested on the following operating systems:

* Centos 6.8
* Centos 7.3
* Ubuntu 14.04
* Ubuntu 16.04

The easiest installation method is via Ansible Galaxy:

```BASH
ansible-galaxy install lobsterdore.fabio
```

In requirements file:

```BASH
---
# requirements.yml

- src: lobsterdore.fabio
  version: v1.2

```

To see available versions please check this roles [Ansible Galaxy page](https://galaxy.ansible.com/lobsterdore/fabio/).




## How to use

This role will install Fabio as a system service, the installation process can be from src
or from a release binary. Once installed this role will write out a properties file for Fabio
and ensure that the service is started.

### Installing a Fabio binary

By default this role will download a pre-compiled version of Fabio from the projects Github repository,
you can change the version installed via the fabio_version var:

```YAML
fabio_version: 1.4.2
```

### Installing Fabio from src

This installation method will install from src with Go 1.8.1, if you wish to
install using a different version of Go then you can update the following vars:

```YAML
---

fabio_go_checksum: "47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b"
fabio_go_version: 1.7.4
fabio_install_from_source: false

```


### Configuring Fabio

To configure Fabio you can use the following variables:

```YAML
---

# Set Fabio's port
fabio_properties_port: 443
# Set arbitrary config options
fabio_properties_additional:
  proxy.keepalivetimeout: "2s"
  proxy.dialtimeout: "30s"
  proxy.maxconn: "5000"

```

The hash ```fabio_properties_additional``` can be used to set any property in Fabio's
[fabio.properties](https://raw.githubusercontent.com/eBay/fabio/master/fabio.properties) file,
keys and values will end up in the form:

```
key = value
```




## Tags

This role uses two tags: **build** and **configure**

* `build` - Installs Fabio, can be used to bake AMIs
* `configure` - Configures Fabio, can be used on boot for pre-baked AMIs




## Development

A Vagrant box is included that you can use to test this role, a Makefile is included as well
that contains some useful targets for testing, to see a list of targets you can do the following:

```BASH
make
```

To run the tests you will the following prerequisites:

* Docker
* Python 2.7
* Python Virtualenv
* Ruby 2.x
* Ruby Bundler

You can run the tests like so:

```BASH
make test
```




## Contributing

If you would like to contribute to this role please open a Github issue first, then open your PR and reference the issue.
