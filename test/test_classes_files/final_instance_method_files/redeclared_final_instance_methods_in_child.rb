# 2 final class methods are redeclared as final class methods in child class
require "methodfinalizer"
class A
  final_instance_methods :method_one
  final_instance_methods :method_two
  def method_one
    "final instance method 'method_one' in A"
  end
  def method_two
    "final instance method 'method_two' in A"
  end
end

class B < A
  final_instance_methods :method_one, :method_two
end