
#
#  this file to fix following  error when `rake db:create'  on postresql.
#  ERROR:  new encoding (UTF8) is incompatible with the encoding of the template database (SQL_ASCII)



# make template0 connectable and 
update pg_database set datallowconn = TRUE where datname = 'template0';
\c template0
update pg_database set datallowconn = FALSE where datname = 'template0';

# make template1 droppabel and drop, and recreate with new encoding
update pg_database set datistemplate=false where datname  = 'template1';
drop database template1;
create database template1 with template = template0  encoding = 'UTF-8';
update pg_database set datistemplate=true where datname  = 'template1';
