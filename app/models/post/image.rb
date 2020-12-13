class Post::Image
  FRAME_IMAGE_PATH = Rails.root.join('app/assets/images/flame.png')
  FONT_SIZE = 32
  INTERLINE_SPACING = (FONT_SIZE * 0.5).round
  COLOR_CODE = '#252828'
  START_X = 65
  START_Y = 60
  MAX_ROWS = 6
  COLS = 16
  ROWS = 10
  OMMIT_MESSAGE = '…（省略させてください。）'

  attr_reader :post

  def initialize(post)
    @post = post
  end

  def path
    path = "images/posts/#{post.id}_#{post.updated_at.to_i}.png"
    image.write(path) unless File.exist?(Rails.root.join('public', path))
    path
  end

  def image
    image = MiniMagick::Image.open(FRAME_IMAGE_PATH)
    image.combine_options do |c|
      c.gravity 'northwest'
      c.pointsize FONT_SIZE
      c.font font_path
      c.interline_spacing INTERLINE_SPACING
      c.stroke COLOR_CODE
      c.annotate "+#{START_X}+#{START_Y},0", formated_body
    end
  end

  def formated_body
    lines = post.body.lines.map { |line| line.scan(/.{1,#{COLS}}/) }.flatten
    lines = lines[0, MAX_ROWS - 1].push(OMMIT_MESSAGE) if lines.size > MAX_ROWS
    lines.join('\n')
  end

  def font_path
    Rails.root.join('app/assets/fonts/ipaexg00401/ipaexg.ttf')
  end
end
