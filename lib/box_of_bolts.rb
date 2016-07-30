class BoxOfBolts < Item 

  def initialize 
   super("Box of bolts", 25)
  end

  def feed(feed)
    feed.heal(20)
  end

end