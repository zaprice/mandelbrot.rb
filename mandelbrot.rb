module Mandelbrot
  # Constants that determine how the image is displayed
  INFINITY_THRESHOLD = 1e+100
  ITERATIONS = 23
  X_SIZE = 2
  Y_SIZE = 1
  SCALE = 200.0
  # If you increase MANDELBROT_EXPONENT above 2, you will get multibrot sets
  MANDELBROT_EXPONENT = 2


  def self.generate
    #Create grid of complex numbers
    grid = build_grid X_SIZE, Y_SIZE, SCALE 
    #Check if iterated polynomial tends to infinity, i.e. if it passes our approximation threshold
    grid.map! { |row| row.map { |num| iterate(num)  < INFINITY_THRESHOLD} }
    #Draw the image
    draw grid
  end

  def self.build_grid x, y, scale
    Array.new(y * 2 * scale) { |row| Array.new(x * 2 * scale) { |col| Complex(col/scale - x, row/scale - y) } }
  end

  def self.iterate c
    z = 0
    ITERATIONS.times do
      z = z ** MANDELBROT_EXPONENT + c
    end
    z.abs
  end

  def self.draw grid
    str = ""
    grid.each do |row|
      row.each do |col|
        str << (col ? "*" : " ")
      end
      str << "\n"
    end
    str
  end

  def self.write filename=nil
    if filename
      File.open(filename, 'w') { |file| file.write generate }
    else 
      puts generate
    end
  end
end