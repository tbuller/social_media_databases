# file: app.rb

require_relative './lib/accounts'
require_relative './lib/posts'
require_relative './lib/databse_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @accounts = accounts
    @posts = posts
  end

  def run
    @io.puts "Welcome to the blog manager!"

    @io.puts "What would you like to do?
    1 - List all posts
    2 - List all accounts"

    @io.puts "Enter your choice:"
    input = @io.gets.chomp
    input == 1 ? @posts.all.id + @posts.all.title : @accounts.all.id + @accounts.all.username
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'socials_test',
    Kernel,
    PostsRepo.new,
    AccountsRepo.new
  )
  app.run
end