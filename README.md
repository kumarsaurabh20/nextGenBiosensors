nextGenBiosensors
=================

A data management and data analysis pipeline for microarrays and metagenomics based experiments


Installation after git, ruby and rails setup
==============================================
*** LOCAL GEMS FOR THE TOOL ***

actionmailer (2.3.11)
actionpack (2.3.11)
activemodel (3.2.13)
activerecord (2.3.11)
activerecord-mysql2-adapter (0.0.3)
activeresource (2.3.11)
activesupport (3.2.13, 2.3.11)
arel (3.0.2)
bio (1.4.3)
builder (3.0.4)
bundler (1.3.5)
cocaine (0.3.2)
columnize (0.3.6)
fastercsv (1.5.5)
gravatar (1.0)
i18n (0.6.1)
jrails (0.6.0)
linecache (0.46)
mime-types (1.23)
multi_json (1.7.3)
mysql (2.9.1)
mysql2 (0.3.11)
paperclip (2.7.4) ## 2.7.4 version is required for file upload functioning. Do not change this version
rack (1.1.6)
rails (2.3.11)
rake (10.0.4)
rbx-require-relative (0.0.9)
ruby-debug (0.10.4)
ruby-debug-base (0.10.4)
rubygems-bundler (1.1.1)
rvm (1.11.3.7)
tzinfo (0.3.37)

*Install imagemagick (last installed version was 6.8.5) from source. (/usr/local/bin default location)

*Copy database.yml from previous folder in microaquadt/config/database.yml

*In the same config folder put gmaps_api_key.yml

*Create database microaquadt_development, as available in the database.yml, in the local database.

Load database schema:

rake db:schema:load
rake db:addfilters (throws some error, need to check)
rake db:addsubtable
rake db:addperson ( its not user table)
rake db:addoligoreal

*We need to create user table or copy/dump from the main microaqua server database. 


For users having higer version Rake gem (10.0.3/4...) 
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

to:

require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'tasks/rails'

gem install rdoc

<= 1.8.6 : unsupported
 = 1.8.7 : gem install rdoc-data; rdoc-data --install
 = 1.9.1 : gem install rdoc-data; rdoc-data --install
>= 1.9.2 : nothing to do! Yay! 


*Load the User table from the existing server or new user records. 
*Load other data for different modules


