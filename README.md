nextGenBiosensors
=================

A data management and data analysis pipeline for microarrays and metagenomics based experiments
Currently upgraded to ruby 1.9.3 and rails 3.2.11. Asset pipeline is not implemented yet and would be implemented in next upgrade. 


nextGenBiosensors app installation after git, ruby and rails setup
----------------------------------------------------------
(for every new installation we need to install all gems with in the project folder.)


*** LOCAL GEMS ***

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

gem install activerecord-mysql2-adapter (required with mysql2)

install imagemagick (last installed version was 6.8.5) from source. (/usr/local/bin default location)

copy database.yml from previous folder in microaquadt/config/database.yml

in the same config folder put gmaps_api_key.yml

create database microaquadt_development, as available in the database.yml, in the local database.

Load database schema:

rake db:schema:load
rake db:addfilters (throws some error, need to check)
rake db:addsubtable

  rake db:addperson ( its not user table)
  rake db:addoligoreal

 we need to create user table or copy/dump from the main microaqua server database. 


Migrations provide forward and backward step changes to the database. In a production environment, incremental changes must be made to the database during deploys: migrations provide this functionality with a rollback failsafe. If you run rake db:schema:load on a production server, you'll end up deleting all your production data. This is a dangerous habit to get into.
That being said, I believe it is a decent practice to occasionally "collapse" migrations. This entails deleting old migrations, replacing them with a single migration (very similar to your schema.rb file) and updating the "schema_migrations" table to reflect this change. BE VERY CAREFUL WHEN DOING THIS! You can very easily delete your production data if you aren't careful.
As a side note, I strongly believe that you should never put data creation in the migration files. The seed.rb file can be used for this, or custom rake or deploy tasks. Putting this into migration files mixes your database schema specification with your data specification and can lead to conflicts when running migration files. 

I came across the same issue...I did what GiridharBandi mentioned above: 
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'
to:
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'tasks/rails'
Rake version 10.0.4 was there in the gem list but when I tried to uninstall, it said that rake is not installed. So I ignored this and proceeded to install rake 0.8.7. Once its installed, I installed rdoc
gem install rdoc

<= 1.8.6 : unsupported
 = 1.8.7 : gem install rdoc-data; rdoc-data --install
 = 1.9.1 : gem install rdoc-data; rdoc-data --install
>= 1.9.2 : nothing to do! Yay!
and then everything started working just fine. 


Load the User table from the existing server or new user records. 
Load other data for different modules



