require "test/unit"

class TestMethodFinalizer < Test::Unit::TestCase
  def test_final_method
    require "methodfinalizer"
    [:final_class_methods, :final_class_method, :final_instance_methods, :final_instance_method].each do |met|
      assert Object.respond_to?(met)
    end
  end
  
  def test_final_class_method_called_with_no_method_arguments
    assert_raises ArgumentError do
      require "test_classes_files/final_class_method_files/final_class_method_called_with_no_method_arguments"
    end
  end
  
  def test_redeclared_final_class_methods_in_child
    assert_raises FinalClassMethodRedeclarationError do
      require "test_classes_files/final_class_method_files/redeclared_final_class_methods_in_child"
    end
  end
  
  def test_redefined_final_class_method_in_child_class
    assert_raises FinalClassMethodRedefinitionError do
      require "test_classes_files/final_class_method_files/redefined_final_class_method_in_child_class"
    end
  end
  
  def test_redefined_final_class_method_in_child_class_using_parent
    assert_raises FinalClassMethodRedefinitionError do
      require "test_classes_files/final_class_method_files/redefined_final_class_method_in_child_class_using_parent"
    end
  end
  
  def test_final_instance_method_called_with_no_method_arguments
    assert_raises ArgumentError do
      require "test_classes_files/final_instance_method_files/final_instance_method_called_with_no_method_arguments"
    end
  end
  
  def test_redeclared_final_instance_methods_in_child
    assert_raises FinalInstanceMethodRedeclarationError do
      require "test_classes_files/final_instance_method_files/redeclared_final_instance_methods_in_child"
    end
  end
  
  def test_redefined_final_instance_method_in_child_instance_using_parent
    assert_raises FinalInstanceMethodRedefinitionError do
      require "test_classes_files/final_instance_method_files/redefined_final_instance_method_in_child_instance_using_parent"
    end
  end
  
  def test_redefined_final_instance_method_in_child_class
    assert_raises FinalInstanceMethodRedefinitionError do
      require "test_classes_files/final_instance_method_files/redefined_final_instance_method_in_child_class"
    end
  end
end
