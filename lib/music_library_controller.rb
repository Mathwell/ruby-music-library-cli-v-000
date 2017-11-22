#require "pry"

class MusicLibraryController
  attr_accessor :path, :music_importer, :files

  def initialize(path='./db/mp3s')
    MusicImporter.new(path).import
    #@files=@music_importer.files
    #@music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    enter=""
    while enter!='exit' do
      enter=gets
      #puts "You entered: #{enter="exit"}"
      case enter
        when "list songs"
          list_songs
        when "list genres"
          list_genres
        when "list artist"
          list_artists
        when "play song"
          play_song
        else
      end

    end
  end
  #require 'pry'


  def list_songs

    #songs= @files.collect{|filename|
    #  filename.split(/\s-\s/)[1]}.sort.uniq
      #puts "Songs! #{songs}"

    Song.all.sort{|a,b| a.name<=>b.name}.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" #+ @files.detect {|file| file.include?(song)}.split(".")[0].to_s
      #puts "#{index}. #{song}"
      #songs
    end
  end

  def list_artists
    #artists= @files.collect{|filename|
    #  filename.split(/\s-\s/)[0]}.sort.uniq
      #puts "Songs! #{songs}"

    Artist.all.sort{|a,b| a.name<=> b.name}.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"# +# @files.detect {|file| file.include?(artist)}.split(".")[0].to_s
    end
  end

  def list_genres
    #genres=@files.collect{|filename|
    #  filename.split(/\s-\s/)[2].split(".")[0]}.sort.uniq
    Genre.all.sort{|a,b| a.name<=> b.name}.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    enter=gets.strip
    if artist=Artist.find_by_name(enter)
    #@files.collect{|filename|  filename.split(/\s-\s/)[1] if filename.split(/\s-\s/)[0]==artist}.sort.uniq unless @files==NilClass
      artist.songs.sort{|a,b| a.name<=> b.name}.each_with_index { |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    enter=gets.strip
    if genre=Genre.find_by_name(enter)
    #@files.collect{|filename|  filename.split(/\s-\s/)[1] if filename.split(/\s-\s/)[0]==artist}.sort.uniq unless @files==NilClass
      artist.songs.sort{|a,b| a.name<=> b.name}.each_with_index { |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def play_song
  end

end
