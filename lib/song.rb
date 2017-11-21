class Song
  extend  Concerns::Findable


  attr_accessor :name, :artist, :genre
  #attr_reader :artist, :genre

  @@all=[]

  def initialize(name, artist=nil, genre=nil)
    @name=name
    self.artist=artist if artist
    self.genre=genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end



  def save
    self.class.all<<self
  end



  def self.create(name)
    song = new(name)
    song.save
    song
    # Or, as a one-liner:
    # new(name).tap{ |s| s.save }

  end

  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre=genre
    genre.add_song(self) unless genre.include?(self)
  end

  def self.save
    all<<self
  end


  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{|s| s.save}
    #puts all
    #parameters=filename.split(/\s-\s/)
    #self.new(parameters[1],Artist.new(parameters[0]),Genre.new(parameters[2].split(".")[0])) if find_by_name(parameters[1])==NilClass
  end

#  def self.find_by_name(name)
#   all.detect{ |s| s.name == name }
 #end

# def self.find_or_create_by_name(name)
#   find_by_name(name) || create(name)
# end


end
