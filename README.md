cwnmyr
======

cwnmyr was a community wireless network management platform developed by
Keegan Quinn for the Personal Telco Project.


Status
------

The code has been stripped down to what may still be valuable components;
as it stands, it is not currently usable.

Any future work related to this project will likely be focused on tools to
process structured text into things like configuration files and maps, to be
used with existing wikis which already contain relevant data.


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
down, but some work was done to update the code to Rails 3.0.

In 2011, work was started on resurrecting the project using Rails 3.1,
however after reappraising the software and its goals, Keegan no longer
felt that the strict, heavily-structured approach which was taken with the
original database design was appropriate. At this point, the code was
stripped down to a few unique bits which may still be useful.

A page about Adhocracy still exists in the Personal Telco Project wiki:
http://wiki.personaltelco.net/Adhocracy
