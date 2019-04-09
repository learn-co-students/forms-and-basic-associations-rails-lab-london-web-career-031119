class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    try(:artist).try(:name)
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    try(:genre).try(:name)
  end

  def note_contents
    notes.map(&:content)
  end

  def note_contents=(notes)
    notes.each do |note|
      self.notes << Note.create(content: note) unless note.empty?
    end
    # self.notes.build(content: notes.reject(&:empty?))
  end
end
