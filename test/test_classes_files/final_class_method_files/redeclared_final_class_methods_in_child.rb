# 2 final class methods are redeclared as final class methods in child class
require "methodfinalizer"
class A
  final_class_methods :method_one
  final_class_methods :method_two
  def self.method_one
    "final class method 'method_one' in A"
  end
  def self.method_two
    "final class method 'method_two' in A"
  end
end

class B < A
  final_class_methods :method_one, :method_two
end