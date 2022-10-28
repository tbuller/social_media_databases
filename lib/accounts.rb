require 'database_connection'
require 'posts'

class Accounts
    attr_accessor :id, :username, :email

    def initialize
      @posts = []
    end
    attr_accessor :posts
    
 
end

class AccountsRepo

    def all
      results = DatabaseConnection.exec_params('SELECT * FROM accounts', [])

      accounts = []


      results.each do |record|
        account = Accounts.new
        account.id = record['id']
        account.username = record['username']
        account.email = record['email']
        
        accounts << account
      end
      return accounts
    end  



    


    def find(acc)
        results = DatabaseConnection.exec_params('SELECT * FROM accounts WHERE id = $1', [acc])

        accounts = []
        results.each do |record|
            account = Accounts.new
            account.id = record['id']
            account.username = record['username']
            account.email = record['email']
            
            accounts << account
          end
          return accounts
  
    end


    def create(username, email)
        sql = "INSERT INTO accounts (username, email) VALUES ($1, $2)"
        results = DatabaseConnection.exec_params(sql, [username, email])

    end

    
    def delete(id)
        sql = "DELETE FROM accounts where id = $1"
        DatabaseConnection.exec_params(sql, [id])
    end


    def update(oldval, newval)
        sql = "UPDATE accounts SET email = $2  WHERE email = $1" 
        results = DatabaseConnection.exec_params(sql, [oldval, newval])

    end

    def find_with_posts(id)
      sql = 'SELECT accounts.id,
                    accounts.username,
                    accounts.email,
                    posts.id AS posts_id,
                    posts.title,
                    posts.contents,
                    posts.views
            FROM accounts
            JOIN posts ON posts.account_id = accounts.id
            WHERE posts.id = $1;'
      
      params = [id]
      
      result = DatabaseConnection.exec_params(sql, params)

      account = Accounts.new

      account.id = result.first['id']
      account.username = result.first['username']
      account.email = result.first['email']

      result.each do |record|
        post = Posts.new
        post.id = record['post_id']
        post.title = record['title']
        post.contents = record['contents']
        post.views = record['views']

        account.posts << post
      end

      return account
    end  



end

