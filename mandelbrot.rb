module Mandelbrot
  INFINITY_THRESHOLD = 1e+1
  ITERATIONS = 23
  GRID_SIZE = 4 #Needs to be even
  SCALE = 50.0

  def self.generate
    #Create grid of complex numbers
    grid = Array.new(GRID_SIZE*SCALE) { |row| Array.new(GRID_SIZE*SCALE) { |col| Complex((col/SCALE)-(GRID_SIZE/2), (row/SCALE)-(GRID_SIZE/2)) } }
    grid.map! { |row| row.map { |num| self.iterate(num) < INFINITY_THRESHOLD} }
    puts draw(grid)
  end

  def self.iterate c
    z = 0
    ITERATIONS.times do
      z = z*z + c
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
end