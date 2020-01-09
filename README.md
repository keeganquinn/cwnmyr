cwnmyr
======

[![Build Status](https://jenkins.quinn.tk/job/cwnmyr/badge/icon)](https://jenkins.quinn.tk/job/cwnmyr/)
[![Code Climate](https://codeclimate.com/github/keeganquinn/cwnmyr/badges/gpa.svg)](https://codeclimate.com/github/keeganquinn/cwnmyr)
[![Documentation Status](http://inch-ci.org/github/keeganquinn/cwnmyr.svg?branch=master)](http://inch-ci.org/github/keeganquinn/cwnmyr)

cwnmyr is an open-source community wireless network management platform
developed to meet the needs of the Personal Telco Project.

See also: http://personaltelco.net/wiki/CwnmyrProject

This is a Rails application, developed with PostgreSQL as a database. It can
be run in any server or container that supports Rails, and should work with
any Ruby and DBMS supported by Rails.

In addition to the Ruby and JavaScript dependencies, which are described in
`Gemfile` and `package.json`, GraphViz must be installed.


Status
------

This software is running in production, with continued development ongoing as
time and resources allow. Several public-facing live instances are operational.

 * Personal Telco live instance: https://nodes.personaltelco.net/
 * Staging deployment: https://cwnmyr-staging.quinn.tk/

Feedback, bug reports, and pull requests are very welcome.


Configuration
-------------

In addition to the standard Rails configuration options, this app allows
several common settings to be controlled through the environment:

 * `DOMAIN_NAME`: Host part of the URL the instance is hosted at. Required.
 * `SECRET_KEY_BASE`: Secret key for the instance. Required.
 * `PORT`: TCP port to listen for HTTP requests. Default is 3000.
 * `BIND`: Unix socket to listen for HTTP requests. Supersedes `PORT` if set.
 * `GMAPS_API_KEY`: Google Maps API key. Required.
 * `PTP_API_KEY`: PTP API key. Only needed to import confidential data.
 * `SMTP_HOST`: SMTP host for outgoing mail. Uses sendmail if not set.
 * `SMTP_USER`: Username for outgoing SMTP authentication. Required for SMTP.
 * `SMTP_PASS`: Password for outgoing SMTP authentication. Required for SMTP.
 * `FACEBOOK_APP_ID`: App ID to use for Facebook authentication.
 * `FACEBOOK_APP_SECRET`: Secret to use for Facebook authentication.
 * `GOOGLE_CLIENT_ID`: Client ID to use for Google authentication.
 * `GOOGLE_CLIENT_SECRET`: Secret to use for Google authentication.
