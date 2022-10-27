require 'posts'
require 'pg'

RSpec.describe PostsRepo do

    def reset_socials
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'socials_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_socials
    end

    it "returns all of the items in the table" do
        repo = PostsRepo.new
  
        
  
        posts = repo.all
  
        expect(posts[0].id).to eq '1'
        expect(posts[0].title).to eq 'Whatever'
        expect(posts[0].contents).to eq 'a load of rubbish'
        expect(posts[0].views).to eq '10000'
        expect(posts[0].account_id).to eq '1'
    end

    it 'finds a piece of data with the id as an arg' do
        repo = PostsRepo.new

        results = repo.find('1')
  
        expect(results.id).to eq '1'
        expect(results.title).to eq 'Whatever'
        expect(results.contents).to eq 'a load of rubbish'
        expect(results.views).to eq '10000'
        expect(results.account_id).to eq '1'
  
    end

    it "creates new post in posts" do
        repo = PostsRepo.new
        repo.create("cats","they are evil", 20000, 2)
        expect(repo.find('5').contents).to eq 'they are evil'
    end

    it "deletes record from posts" do

        repo = PostsRepo.new
        repo.delete(1)
        posts = repo.all
        expect(posts.length).to eq 3
  
    end


    it "updates views" do
        repo = PostsRepo.new
        repo.update(19, 100)
        expect(repo.find('4').views).to eq '100'
    end


end