class Song
  extend  Concerns::Findable


  attr_accessor :name, :artist, :genre
  #attr_reader :artist, :genre

  @@all=[]

  def initialize(name, artist="", genre="")
    @name=name
    self.artist=artist unless artist==""
    self.genre=genre unless genre==""
  end

  def self.all
    @@all
  end


  def self.create(name)
    song=new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre=genre
    genre.add_song(self)
  end

  def self.save
    all<<self
  end

  def self.new_from_filename(filename)
    parameters=filename.split(" - ")
    artist_name, song_name, genre_name =  parameters[0], parameters[1], parameters[2]. gsub(".mp3","")
    #self.new(parameters[1],Artist.new(parameters[0]),Genre.new(parameters[2].split(".")[0])) if find_by_name(parameters[1])==NilClass
    artist=Artist.find_or_create_by_name(artist_name) #,Artist.new(parameters[0]),Genre.new(parameters[2].split(".")[0]))
    genre=Genre.find_or_create_by_name(genre_name)
    new(song_name,artist,genre)

  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{|s| s.save}
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all<<self
  end
end
