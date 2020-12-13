class Post < ApplicationRecord
  delegate :path, to: :image, prefix: true

  def image
    @image ||= Post::Image.new(self)
  end
end
