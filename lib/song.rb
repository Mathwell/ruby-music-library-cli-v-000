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

  def destroy_all
    self.all.clear
  end

end


  def save
    self.class.all<<self
  end



  def self.create(name)
    self.new(name).save
    self
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
    parameters=filename.split(/\s-\s/)
    #self.new(parameters[1],Artist.new(parameters[0]),Genre.new(parameters[2].split(".")[0])) if find_by_name(parameters[1])==NilClass
    self.find_or_create_by_name(parameters[1]) #,Artist.new(parameters[0]),Genre.new(parameters[2].split(".")[0]))

  end

  def self.create_from_filename(filename)
    new_from_filename(filename)
    #puts all
    #parameters=filename.split(/\s-\s/)
    #self.new(parameters[1],Artist.new(parameters[0]),Genre.new(parameters[2].split(".")[0])) if find_by_name(parameters[1])==NilClass
  end

end
