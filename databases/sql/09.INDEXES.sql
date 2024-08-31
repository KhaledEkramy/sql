-- indexes
-- b-tree by default    
-- unique
-- primary key
-- foreign key

-- column indexes

-- HEAP Table: is a table without a clustered index (heap table) which means each time you want to retrieve a row, you have to scan the entire table.
-- Tables are stored in your disk on pages, and each page has a size of 8KB. When you create a table without a clustered index, the rows are stored in the order they were inserted. This means that the rows are not sorted in any way, and the only way to find a row is to scan the entire table.
-- When you create a clustered index, the rows are stored in the order of the index key. This means that the rows are sorted, and you can find a row much faster. When you create a clustered index, you are creating a B-tree index, and the leaf nodes of the B-tree index contain the actual data rows.
-- When you create a non-clustered index, the leaf nodes of the B-tree index contain the index key and a pointer to the actual data row. This means that when you use a non-clustered index to find a row, you first find the row in the index, and then you use the pointer to find the actual data row.
-- So the actual difference between a clustered index and a non-clustered index is that the leaf nodes of a clustered index contain the actual data rows, while the leaf nodes of a non-clustered index contain the index key and a pointer to the actual data row.
-- But the structure of the B-tree index is the same for both clustered and non-clustered indexes.
-- Indexes sometimes can be created automatically by the database engine, for example, when you create a primary key or a unique constraint, the database engine will automatically create an index for you.

-- important tutorial: https://www.sqlservertutorial.net/sql-server-indexes/

DROP DATABASE IF EXISTS testdb;
CREATE DATABASE IF NOT EXISTS testdb;

USE testdb;

CREATE TABLE t1 (
    id INT, 
    first_name VARCHAR(20),
    INDEX (first_name)
    );

DESC t1;

-- other ways to define index
CREATE INDEX idx_first_name ON t1 (first_name);

-- drop index

DROP INDEX idx_first_name ON t1;
-- insert some rows
INSERT INTO t1 VALUES (1, 'ahmed'), (2, 'aya'), (3, 'john'),
                      (4, 'sami'), (5, 'fekri'), (6, 'michael'),
                      (7, 'eissa'), (8, 'samira'), (9, 'jane');
TABLE t1;

SELECT * FROM t1 WHERE first_name = 'ahmed';

-- explain query plan

EXPLAIN SELECT * FROM t1;
EXPLAIN SELECT * FROM t1 WHERE id > 2;
EXPLAIN SELECT * FROM t1 WHERE first_name like 'ahmed';

-- show on mysql workbench