require 'methodfinalizer'

class Aa
  final_class_methods :m_one, :m_two
  final_instance_methods :m_three, :m_four
  
  def self.m_one
    "'m_one' in Aa"
  end
  
  def self.m_two
    "'m_two' in Aa"
  end
  
  def m_three
    "'m_three' in Aa"
  end
  
  def m_four
    "'m_four' in Aa"
  end
end

class Bb < Aa
  begin
    final_class_methods :m_one
  rescue
    final_class_methods :m_five
  end
  
  begin
    final_class_methods :m_two
  rescue
    final_class_methods :m_six
  end
  
  begin
    final_instance_methods :m_three
  rescue
    final_instance_methods :m_seven
  end
  
  begin
    final_instance_methods :m_four
  rescue
    final_instance_methods :m_eight
  end
  
  def self.m_five
    "'m_five' in Bb"
  end
  
  def self.m_six
    "'m_six' in Bb"
  end
  
  def m_seven
    "'m_seven' in Bb"
  end
  
  def m_eight
    "'m_eight' in Bb"
  end
end