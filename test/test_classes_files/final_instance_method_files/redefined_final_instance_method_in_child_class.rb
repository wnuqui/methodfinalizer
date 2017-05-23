# final class method is redefined in child class
require "methodfinalizer"
class A
  final_instance_methods :method_one
  def method_one
    "final class method 'method_one' in A"
  end
end

class B < A
  def method_one
    "final instance method 'method_one' in B"
  end
end