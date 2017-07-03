cwnmyr
======

[![Build Status](https://quinn.tk/jenkins/job/cwnmyr/badge/icon)](https://quinn.tk/jenkins/job/cwnmyr/)

cwnmyr is an open-source community wireless network management platform
developed to meet the needs of the Personal Telco Project.

See also: http://personaltelco.net/wiki/CwnmyrProject

This is a Rails application in pure Ruby, developed with PostgreSQL as a
database. It can be run in any server or container that supports Rails, and
should work with any other DBMS supported by Rails.


Status
------

This software is partially functional, with continued development ongoing.
Several public-facing live instances of the app are now operational.

 * Personal Telco instance: https://cwnmyr.personaltelco.net/
 * Production deployment: https://cwnmyr.quinn.tk/
 * Staging deployment: https://cwnmyr-staging.quinn.tk/
 * Test deployment: https://cwnmyr.herokuapp.com/

Feedback, bug reports, and pull requests are very welcome.


Configuration
-------------

In addition to the standard Rails configuration options, this app allows
several common settings to be controlled through the environment:

 * DOMAIN_NAME: Host part of the URL the instance is hosted at. Required.
 * SECRET_KEY_BASE: Secret key for the instance. Required.
 * PORT: TCP port to listen for HTTP requests. Default is 3000.
 * BIND: Unix socket to listen for HTTP requests. Supersedes PORT if set.
 * GMAPS_API_KEY: Google Maps API key. Required.
 * PTP_API_KEY: PTP API key. Only needed to import confidential data.
 * SMTP_HOST: SMTP host for outgoing mail. Uses sendmail if not set.
 * SMTP_USER: Username for outgoing SMTP authentication. Required if using SMTP.
 * SMTP_PASS: Password for outgoing SMTP authentication. Required if using SMTP.
