require 'test/unit'
require 'test_classes_files/method_finalizer_usage'

class TestMethodFinalizerUsage < Test::Unit::TestCase
  def test_final_class_methods
    assert_equal "'m_one' in Aa",   Aa.m_one
    assert_equal "'m_two' in Aa",   Aa.m_two
    assert_equal "'m_one' in Aa",   Bb.m_one
    assert_equal "'m_two' in Aa",   Bb.m_two
    assert_equal "'m_five' in Bb",  Bb.m_five
    assert_equal "'m_six' in Bb",   Bb.m_six
  end
  
  def test_final_instance_methods
    assert_equal "'m_three' in Aa", Aa.new.m_three
    assert_equal "'m_four' in Aa",  Aa.new.m_four
    assert_equal "'m_three' in Aa", Bb.new.m_three
    assert_equal "'m_four' in Aa",  Bb.new.m_four
    assert_equal "'m_seven' in Bb", Bb.new.m_seven
    assert_equal "'m_eight' in Bb", Bb.new.m_eight
  end
  
  def test_get_final_singleton_methods
    assert Bb.respond_to?(:get_final_singleton_methods)
    assert_equal [:m_five, :m_one, :m_six, :m_two], Bb.get_final_singleton_methods(true)
    assert_equal [:m_one, :m_two], Aa.get_final_singleton_methods(true)
  end
  
  def test_get_final_instance_methods
    assert Bb.respond_to?(:get_final_instance_methods)
    assert_equal [:m_eight, :m_four, :m_seven, :m_three], Bb.get_final_instance_methods(true)
    assert_equal [:m_four, :m_three], Aa.get_final_instance_methods(true)
  end
  
  def test_singleton_method_exist
    assert Bb.respond_to?(:final_singleton_method_exists?)
    assert Bb.respond_to?(:final_class_method_exists?)
    assert_raises ArgumentError do
      Bb.final_singleton_method_exists?("m_five")
    end
    assert_raises ArgumentError do
      Bb.final_singleton_method_exists?
    end
    assert Bb.final_singleton_method_exists?(:m_five)
    assert !Aa.final_singleton_method_exists?(:m_five)
  end
  
  def test_instance_method_exist
    assert Bb.respond_to?(:final_instance_method_exists?)
    assert_raises ArgumentError do
      Bb.final_instance_method_exists?("m_three")
    end
    assert_raises ArgumentError do
      Bb.final_instance_method_exists?
    end
    assert Bb.final_instance_method_exists?(:m_three)
    assert !Aa.final_instance_method_exists?(:m_seven)
    assert !Bb.final_instance_method_exists?(:m_ten)
  end
end
