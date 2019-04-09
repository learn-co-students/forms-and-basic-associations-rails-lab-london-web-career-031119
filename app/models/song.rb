class Song < ActiveRecord::Base
  has_many :notes
  belongs_to :artist
  belongs_to :genre

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(array) #array is params[:note_contents]
    array.delete("") #delete empty input from params
    array.each {|content| self.notes.build(content:content)} #using the content from form to create a new note associated with this song
  end

  def note_contents
      self.notes.map(&:content)
  end

end
