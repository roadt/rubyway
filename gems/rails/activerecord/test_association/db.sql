


use test

show tables


create  table if not exists users (id int primary key auto_increment, name varchar(256));

create table if not exists userinfo (id int primary key auto_increment, name varchar(256), value varchar(256), user_id int);

create table if not exists  groups (id int primary key auto_increment, name varchar(256));

create table if not exists groups_users(id int primary key auto_increment, user_id int, group_id int);

create table if not exists forums (id int primary key auto_increment, name varchar(256), owner_id int);

