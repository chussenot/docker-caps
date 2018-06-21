Docker Capabilities & Seccomp
=============================

This project will help to add a understanding of security in docker.   
The main tests use the [Goss](https://github.com/aelsabbahy/goss) project.

Auditing
--------

[Sysdig Falco](Behavioral Activity Monitoring) is used to monitor the containers.
Sysdig Falco is an auditing tool as opposed to enforcement tools like Seccomp or AppArmor.

[![Build Status](https://travis-ci.org/chussenot/docker-caps.svg?branch=master)](https://travis-ci.org/chussenot/docker-caps)

Ressources
----------

* [Docker Capabilities Explain](https://rhelblog.redhat.com/2016/10/17/secure-your-containers-with-this-one-weird-trick/)
* [Falco Workshop](https://github.com/mstemm/labs/blob/master/security/falco/README.md)
