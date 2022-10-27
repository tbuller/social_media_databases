require 'database_connection'

class Posts
    attr_accessor :id, :title, :contents, :views, :account_id
end

class PostsRepo

    def all
      results = DatabaseConnection.exec_params('SELECT * FROM posts', [])

      posts = []


      results.each do |record|
        post = Posts.new
        post.id = record['id']
        post.title = record['title']
        post.contents = record['contents']
        post.views = record['views']
        post.account_id = record['account_id']
        
        posts << post
      end
      return posts
    end


    def find(id)
        results_set = DatabaseConnection.exec_params('SELECT * FROM posts WHERE id = $1', [id])

        record = results_set[0]
        
        post = Posts.new
        #binding.irb
        post.id = record['id']
        post.title = record['title']
        post.contents = record['contents']
        post.views = record['views']
        post.account_id = record['account_id']
            
           
        return post
  
    end


    def create(title, contents, views, account_id)
        sql = "INSERT INTO posts (title, contents, views, account_id) VALUES ($1, $2, $3, $4)"
        results = DatabaseConnection.exec_params(sql, [title, contents, views, account_id])
        return nil
    end


    def delete(id)
        sql = "DELETE FROM posts where id = $1"
        DatabaseConnection.exec_params(sql, [id])
    end

    
    def update(oldval, newval)
        sql = "UPDATE posts SET views = $2  WHERE views = $1" 
        results = DatabaseConnection.exec_params(sql, [oldval, newval])
    end

end