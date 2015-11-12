cwnmyr
======

cwnmyr is a community wireless network management platform developed by
Keegan Quinn for the Personal Telco Project.

See also: http://personaltelco.net/wiki/CwnmyrProject


Installation
------------

bundle
rake db:migrate
rails s


Status
------

In flux. This code is being rebuilt to modern standards and to fit the
current needs of the Personal Telco Project.




History
-------

This project began, in concept, around the same time as the Personal Telco
Project itself - around the turn of the 21st century. Originally, it was
called Adhocracy and was written in PHP with a MySQL database.

From 2002 through 2004, Adhocracy was picked up by Keegan Quinn and rewritten
in Python with a PostgreSQL database. During this time, it became usable for
recording node information and gained some basic configuration generation
abilities.

From 2005 through 2007, the project was again rewritten in Ruby on Rails,
using the same PostgreSQL database design that had been created previously.
It gained a usable web interface and was put into production with some small
degree of success.

By 2010, the production installation had fallen into disuse and was taken
down, but some work was done to update the code to Rails 3.0. During this
time, the project was also relocated from a dusty Subversion repository
to a Google Code project.

In 2011, work was started on resurrecting the project using Rails 3.1,
and it was moved to a new GitHub project. However, after reappraising the
software's design and its goals, Keegan no longer felt that the strict,
heavily-structured approach which was taken with the original database
design was appropriate. At this point, the code was stripped down to a
few unique bits which may still be useful.
