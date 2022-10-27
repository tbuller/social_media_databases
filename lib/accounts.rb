require 'database_connection'

class Accounts
    attr_accessor :id, :username, :email
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


    def delete(username)
        sql = "DELETE FROM accounts where username = $1"
        results = DatabaseConnection.exec_params(sql, [username])
    end


    def update(oldval, newval)
        sql = "UPDATE accounts SET email = $2  WHERE email = $1" 
        results = DatabaseConnection.exec_params(sql, [oldval, newval])

    end


end

