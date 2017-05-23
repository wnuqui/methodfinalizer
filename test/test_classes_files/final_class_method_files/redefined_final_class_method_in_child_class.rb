# final class method is redefined in child class
require "methodfinalizer"
class A
  final_class_methods :method_one
  def self.method_one
    "final class method 'method_one' in A"
  end
end

class B < A
  def self.method_one
    "final class method 'method_one' in B"
  end
end