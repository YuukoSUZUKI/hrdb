# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

  #DBユーザ作成
  mysql -u root
  CREATE USER 'hrdb-user'@'localhost' IDENTIFIED BY 'password';
  grant all on hrdb.* to 'hrdb-user'@localhost identified by 'password';
  grant all on hrdb_test.* to 'hrdb-user'@localhost identified by 'password';

  rails db:create
  rails db:migrate


* Database initialization

  rails db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
