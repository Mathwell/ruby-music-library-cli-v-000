require 'pry'
class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
      @path=path
      @songs=[]
    end

    def files
      mp3s=@path+"/*.mp3"
      @files ||= Dir.glob(mp3s).collect {|item|
        item.gsub("#{path}/","")}
    end


    def import
        files.each do |file|
           @songs<<Song.create_from_filename(file)
        end
    end

end
