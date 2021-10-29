module YahooFantasy
  module Resource 
    class Game
      # Note - this is not a PositionType object like in the other resources, this is 
      # an array of strings which match the PositionType#type
      StatCategory = Struct.new(:stat_id, :name, :display_name, :sort_order, :position_type) 
    end 
  end 
end 