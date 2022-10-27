TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE accounts RESTART IDENTITY CASCADE; 

INSERT INTO accounts (username, email) VALUES ('David', 'dave@gmail.com');
INSERT INTO accounts (username, email) VALUES ('Tim', 'timothy@yahoo.com');

INSERT INTO posts (title, contents, views, account_id) VALUES ('Whatever', 'a load of rubbish', 10000, 1);
INSERT INTO posts (title, contents, views, account_id) VALUES ('Followup', 'not much better', 5000, 1);
INSERT INTO posts (title, contents, views, account_id) VALUES ('A response to whatever', 'I very much disagree', 3, 2);
INSERT INTO posts (title, contents, views, account_id) VALUES ('My thoughts', 'NOt many thoughts in here actually', 19, 2);


