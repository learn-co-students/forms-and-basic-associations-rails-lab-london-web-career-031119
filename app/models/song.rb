class Song < ActiveRecord::Base
  # add associations here
  has_many :notes
  belongs_to :artist
  belongs_to :genre

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
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

  def note_contents=(notes)
    # iterate over array of strings and get the strings if not empty
    notes.each do |content|
      if !content.blank?
      note = Note.create(content: content) if !content.empty?
      self.notes << note
      end
    end
  end

  def note_contents
    self.notes.map {|note| note.content}
  end
end
