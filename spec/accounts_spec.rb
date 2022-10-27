require 'accounts'
require 'pg'

RSpec.describe AccountsRepo do

    def reset_socials
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'socials_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_socials
    end

    it "returns all of the items in the table" do
      repo = AccountsRepo.new

      

      accounts = repo.all

      expect(accounts[0].id).to eq '1'
      expect(accounts[0].username).to eq 'David'
      expect(accounts[0].email).to eq 'dave@gmail.com'
    end

    it 'finds a piece of data with the id as an arg' do
      repo = AccountsRepo.new

      account = Accounts.new

      result = repo.find('2')
      expect(result[0].id).to eq '2'
      expect(result[0].username).to eq 'Tim'
      expect(result[0].email).to eq 'timothy@yahoo.com'

    end  

    it "creates new account in accounts" do
      repo = AccountsRepo.new
      repo.create("Jeff","JJ@gmail.com")
      expect(repo.find('3')[0].username).to eq 'Jeff'
    end

    it "deletes record from accounts" do

      repo = AccountsRepo.new
      repo.delete("David")
      expect{repo.find('1')[0].username}.to raise_error

    end

    it "update email address" do
      repo = AccountsRepo.new
      repo.update("timothy@yahoo.com", "tim@yahoo.com")
      expect(repo.find('2')[0].email).to eq 'tim@yahoo.com'
    end


  end