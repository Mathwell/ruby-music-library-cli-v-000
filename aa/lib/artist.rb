class Artist
  extend Memorable::ClassMethods, Concerns::Findable
  include Memorable::InstanceMethods
  attr_accessor :name
  @@all=[]


  def initialize(name)
    @name=name
    @songs=[]
  end

  def self.all
    @@all
  end

  def destroy_all
    self.all.clear
  end

  def save
    self.class.all<<self
  end


  def self.create(name)
    artist = new(name)
     artist.save
     artist
  end

  def add_song(song)
    song.artist=self unless song.artist #==self
    @songs<<song unless @songs.include?(song)
    #@songs.detect {|s|  s.name== song}.artist=self
  end

  def songs
    @songs
  end

  def genres
    @songs.collect{|s| s.genre}.uniq
  end

end
