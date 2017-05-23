== methodfinalizer

   by Wilfrido T. Nuqui Jr.
   dofreewill22@gmail.com
   wnuqui@exist.com

== DESCRIPTION:

  'methodfinalizer' is a gem that allows you to declare final class and instance methods in your ruby program.

== FEATURES:

  can declare
    final class method(s), or
    final instance method(s),
    implement it and feel safe they will not be redefined

== SYNOPSIS:

  Require 'rubygems' and 'methodfinalizer' gems.

    require 'rubygems'
    require 'methodfinalizer'

    class A
      # declare your final class and instance methods
      final_class_method :method_one
      final_instance_methods :method_two, :method_three
     
      def A.method_one
        "'method_one' class method in A declared as final"
      end
     
      def method_two
        "'method_two' instance method in A declared as final"
      end

      def method_three
        "'method_three' instance method in A declared as final"
      end
    end
   
  Now,
 
    class B < A
      # attempting to redeclare 'method_one' as final class method
      final_class_method :method_one
    end
 
  will yield this error
 
    FinalClassMethodRedeclarationError: cannot declare 'method_one' as final method in child B as parent A declared it already as such
 
  and when,
   
    class B < A
      # attempting to redefine 'method_one'
      def self.method_one
        "'method_one' class method in B"
      end
    end
 
  will give you
 
    FinalClassMethodRedefinitionError: cannot redefine 'method_one' because it is already defined as final class method in parent A.


== REQUIREMENTS:

* rubygems

== INSTALL:

* sudo gem install methodfinalizer
