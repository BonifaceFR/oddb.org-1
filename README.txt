= oddb.org

* http://scm.ywesee.com/?p=oddb.org/.git;a=summary
* http://choddb.rubyforge.org/

== DESCRIPTION:

Open Drug Database for Switzerland. See the live version at http://ch.oddb.org

== FEATURES/PROBLEMS:

* Some email-Addresses are still hardcoded. That needs to be fixed and placed into etc/oddb.yml
* If you install oddb.org via gem please also see these instructions:
  * http://dev.ywesee.com/wiki.php/Choddb/Gem

== REQUIREMENTS:

* see Guide.txt

== TESTS:

* to run the Tests you need to do
  * rcov test/suite.rb
  * look at the index.html in the coverage directory

== LOCAL DOCUMENTATION:

* To build your local documentation do:
  * rdoc1.9 --op documentation

== INSTALL:

* sudo gem install oddb.org

== DEVELOPERS:

* Zeno R.R. Davatz
* Masaomi Hatakeyama
* Hanney Wyss (up to Version 1.0)

== FRENCH TRANSLATION HELP

* Herve Robin

== LICENSE:

* GPLv2.1
