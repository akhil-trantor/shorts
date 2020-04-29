# README


### Ruby version
    Ruby 2.5.1

### cross cutting notes
* you may have to prepend commands with "bundle exec" depending on your setup
* There's no standard around rb_env or rvm

## Setting up the app
* install homebrew (https://brew.sh/)
* `brew install postgres` (or do elephant version from postgresapp.com)
* git clone https://github.com/ApplePieGitHub/apc
* create config/application.yml file and add below given configuration values.
* get ruby with https://rvm.io/rvm/install
* `\curl -sSL https://get.rvm.io | bash`
* `rvm install ruby-2.5.1`
* `gem install bundler`
* `bundle install`
* start postgres (postgres -D /usr/local/var/postgresql &)
* `rake db:create`
* `rake db:migrate`

### Configuration

Add following configuration values inside config/application.yml file:
- DB_USER_NAME: '********'
- DB_PASSWORD: '********'
- TEST_DB_NAME: '********'
- DB_NAME: '********'

### How to run the test suite
Run the following command in your terminal:
`rspec`

### How to check test coverage
Run the following command in your terminal:
`open coverage/index.html`

### Reason For Scalability Issue:
As the number of records increase, after a certain level, the application response time will start to increase.
The number of records in link_analytics table will be even more then the links table, therefore
the queries for the addition of new record in link_analytics and updation of click_counts in links table will take longer time and will further contribute to the appication's increased response time.
Performing simpler solutions(indexing or data caching) alone will not be able to fix the
scalability issues.

### Possible Solution For Scalability Issue:
Following are the possibe solutions which can help reduce the scalability issues:

1) **Use of load balancers and Orchestration Tools (Kubernetes):**
Use of load balancers and Orchestration tools will help to automate the process of deployment and upscaling/descaling of servers.

2) **Use of Separate DB for Analytics Data(Preferably NoSQL):**
Remove analytics and click_count columns from RDBMS DB and shift to separate Database.

3) **Use of Background Jobs(Sidekiq or Resque) for the Data Analytics write operations.**

4) **Use of Master Slave Architecture for DB:**
After shifting the Data Analytics and click counts records to separate DB, it is obvious
that there will be more read queries in our application than the Data Modification queries.
Therefore use of Master-Slave Architecture can help improve the app response time.

5) **Perform caching on the links table records**

6) **Database Sharding or Horizontal Partitioning:**
Sharding is necessary if a dataset is too large to be stored in a single database.
Data is partitioned into mulitple databases(using various algorithms available) inside a cluster.

7) **DataBase CleanUp:**
Archiving of inactive records or less visited records can help reduce the number of records.

