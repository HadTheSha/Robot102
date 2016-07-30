
class Robot
  class RobotDead < StandardError
  end

  attr_reader  :items_weight, :items
  attr_accessor :equipped_weapon, :robot_position

  def initialize(robot_position = [0,0])
    @robot_position = robot_position
    @items = []
    @items_weight = 0 
    @health = 100
    @attack_power = 5
    @equipped_weapon = nil 
  end

  def position
  @robot_position 
  end

  def health
    @health
  end

  def move_left
    @robot_position = [@robot_position[0] - 1 ,0]
  end

  def move_right
    @robot_position = [@robot_position[0] + 1 ,0]
  end

  def move_up 
    @robot_position = [0 , @robot_position[1] + 1]
  end

  def move_down
    @robot_position = [0, @robot_position[1] - 1]
  end

  def items 
    @items
  end

  def pick_up(item)
    if item.weight + @items_weight <= 250 
      @items.push (item)
      @items_weight += item.weight
      if item.is_a? Weapon
        @equipped_weapon = item 
      elsif item.instance_of?(BoxOfBolts) && self.health <= 80
        item.feed(self)
      end
      true
    else 
      nil 
    end
  end

  def wound(n)
   if @health - n  < 0 
      @health = 0
    else 
      @health -= n 
    end
  end 

  def heal(n)
    if n + @health > 100 
      @health = 100
    else 
      @health += n 
    end
  end

  def attack(robot)
    if (self.robot_position[0] - robot.robot_position[0]).abs == 1 || (self.robot_position[0] - robot.robot_position[0]).abs == 2 
   elsif (self.robot_position[1] - robot.robot_position[1]).abs == 1 ||(self.robot_position[1] - robot.robot_position[1]).abs == 2
       if @equipped_weapon == nil 
        robot.wound(@attack_power)
      else 
       @equipped_weapon.hit(robot)
       @equipped_weapon = nil
      end
    end
  end

  def heal!(robot)
    if @health <= 0 
      raise RobotDead, "Dead robot, can't help it"
    else 
      heal(robot)
    end
  end

  def attack!(robot)
    if !robot.is_a?(Robot) 
      raise RobotDead, "Can only attack a Robot!"
    else 
      attack(robot)
    end
  end
end
