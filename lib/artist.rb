class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all=[]

  def initialize(name)
    @name=name
    @songs=[]
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
    self.new(name).save
    self
  end

  def add_song(song)
    song.artist=self unless song.artist==self
    @songs<<song unless @songs.include?(song)
    #@songs.detect {|s|  s.name== song}.artist=self
  end

  def songs
    @songs
  end

  def genres
    @songs.collect{|song| song.genre}.uniq
  end

end
