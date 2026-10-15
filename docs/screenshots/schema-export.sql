-- ----------------------------------------------------------
-- MDB Tools - A library for reading MS Access database files
-- Copyright (C) 2000-2011 Brian Bruns and others.
-- Files in libmdb are licensed under LGPL and the utilities under
-- the GPL, see COPYING.LIB and COPYING files respectively.
-- Check out http://mdbtools.sourceforge.net
-- ----------------------------------------------------------

SET client_encoding = 'UTF-8';

CREATE TABLE IF NOT EXISTS "account"
 (
	"accountid"			SERIAL, 
	"balance"			NUMERIC(15,2), 
	"lastpaymentdate"			TIMESTAMP WITHOUT TIME ZONE, 
	"lastpaymentamount"			NUMERIC(15,2), 
	"type"			VARCHAR (255), 
	"customerid"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "account_customerid_idx" ON "account" ("customerid");
ALTER TABLE "account" ADD CONSTRAINT "account_pkey" PRIMARY KEY ("accountid");

CREATE TABLE IF NOT EXISTS "branch"
 (
	"branchnumber"			VARCHAR (255) NOT NULL, 
	"address"			VARCHAR (255), 
	"city"			VARCHAR (255), 
	"province"			VARCHAR (255), 
	"storagespace"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "branch" ADD CONSTRAINT "branch_pkey" PRIMARY KEY ("branchnumber");

CREATE TABLE IF NOT EXISTS "branchitem"
 (
	"branchnumber"			VARCHAR (255), 
	"itemid"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "branchitem_itemid_idx" ON "branchitem" ("itemid");

CREATE TABLE IF NOT EXISTS "customer"
 (
	"customerid"			SERIAL, 
	"company"			VARCHAR (255), 
	"name"			VARCHAR (255), 
	"address"			VARCHAR (255), 
	"city"			VARCHAR (255), 
	"province"			VARCHAR (255), 
	"telephone"			VARCHAR (255), 
	"dateofestablishment"			TIMESTAMP WITHOUT TIME ZONE, 
	"languageofcommunication"			VARCHAR (255)
);

-- CREATE INDEXES ...
ALTER TABLE "customer" ADD CONSTRAINT "customer_pkey" PRIMARY KEY ("customerid");

CREATE TABLE IF NOT EXISTS "dependent"
 (
	"dependentid"			SERIAL, 
	"name"			VARCHAR (255), 
	"age"			INTEGER, 
	"relationship"			VARCHAR (255), 
	"employeeid"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "dependent_employeeid_idx" ON "dependent" ("employeeid");
ALTER TABLE "dependent" ADD CONSTRAINT "dependent_pkey" PRIMARY KEY ("dependentid");

CREATE TABLE IF NOT EXISTS "employeeskills"
 (
	"employeeid"			INTEGER NOT NULL, 
	"skillid"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "employeeskills_skillid_idx" ON "employeeskills" ("skillid");

CREATE TABLE IF NOT EXISTS "item"
 (
	"itemid"			SERIAL, 
	"description"			VARCHAR (255), 
	"size"			INTEGER, 
	"type"			VARCHAR (255)
);

-- CREATE INDEXES ...
ALTER TABLE "item" ADD CONSTRAINT "item_pkey" PRIMARY KEY ("itemid");

CREATE TABLE IF NOT EXISTS "itemcompostion"
 (
	"parentitemid"			INTEGER NOT NULL, 
	"componentitemid"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "itemcompostion_componentitemid_idx" ON "itemcompostion" ("componentitemid");
CREATE INDEX "itemcompostion_parentitemid_idx" ON "itemcompostion" ("parentitemid");

CREATE TABLE IF NOT EXISTS "skill"
 (
	"skillid"			SERIAL, 
	"skillname"			VARCHAR (255)
);

-- CREATE INDEXES ...
ALTER TABLE "skill" ADD CONSTRAINT "skill_pkey" PRIMARY KEY ("skillid");

CREATE TABLE IF NOT EXISTS "employee"
 (
	"employeeid"			SERIAL, 
	"name"			VARCHAR (255), 
	"street"			VARCHAR (255), 
	"city"			VARCHAR (255), 
	"province"			VARCHAR (255), 
	"telephone"			VARCHAR (255), 
	"dateofhire"			TIMESTAMP WITHOUT TIME ZONE, 
	"title"			VARCHAR (255), 
	"salary"			NUMERIC(15,2), 
	"dateofbirth"			TIMESTAMP WITHOUT TIME ZONE, 
	"age"			INTEGER, 
	"branchnumber"			VARCHAR (255)
);

-- CREATE INDEXES ...
ALTER TABLE "employee" ADD CONSTRAINT "employee_pkey" PRIMARY KEY ("employeeid");

CREATE TABLE IF NOT EXISTS "order"
 (
	"orderid"			SERIAL, 
	"orderdate"			TIMESTAMP WITHOUT TIME ZONE, 
	"creditauthorizationstatus"			BOOLEAN NOT NULL, 
	"customerid"			INTEGER, 
	"branchnumber"			VARCHAR (255), 
	"itemid"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "order_customerid_idx" ON "order" ("customerid");
CREATE INDEX "order_itemid_idx" ON "order" ("itemid");
ALTER TABLE "order" ADD CONSTRAINT "order_pkey" PRIMARY KEY ("orderid");


-- CREATE Relationships ...
ALTER TABLE "MSysNavPaneGroups" ADD CONSTRAINT "msysnavpanegroups_groupcategoryid_fk" FOREIGN KEY ("groupcategoryid") REFERENCES "MSysNavPaneGroupCategories"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "MSysNavPaneGroupToObjects" ADD CONSTRAINT "msysnavpanegrouptoobjects_groupid_fk" FOREIGN KEY ("groupid") REFERENCES "MSysNavPaneGroups"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;
