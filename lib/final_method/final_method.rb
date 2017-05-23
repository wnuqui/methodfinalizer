require File.dirname(__FILE__) + '/final_method_version'

module OOP
  module Concepts
    ##
    # 'methodfinalizer' is a gem that allows you to declare final class and instance methods in your ruby program.
    #
    # == Using 'methodfinalizer'
    #
    # === Basics
    #
    # Require 'rubygems' and 'methodfinalizer' gems.
    #
    #   require 'rubygems'
    #   require 'methodfinalizer'
    #
    #   class A
    #     # declare your final class and instance methods
    #     final_class_method :method_one
    #     final_instance_methods :method_two, :method_three
    #     
    #     def A.method_one
    #        "'method_one' class method in A declared as final"
    #     end
    #     
    #     def method_two
    #       "'method_two' instance method in A declared as final"
    #     end
    #
    #     def method_three
    #       "'method_three' instance method in A declared as final"
    #     end
    #   end
    #   
    # Now,
    # 
    #   class B < A
    #     # attempting to redeclare 'method_one' as final class method
    #     final_class_method :method_one
    #   end
    # 
    # will yield this error
    # 
    #   FinalClassMethodRedeclarationError: cannot declare 'method_one' as final method in child B as parent A declared it already as such
    # 
    # and when,
    #   
    #   class B < A
    #     # attempting to redefine 'method_one'
    #     def self.method_one
    #       "'method_one' class method in B"
    #     end
    #   end
    # 
    # will give you
    # 
    #   FinalClassMethodRedefinitionError: cannot redefine 'method_one' because it is already defined as final class method in parent A.
    ##

    module FinalMethod
      include FinalMethodVersion
      @@final_singleton_methods, @@final_instance_methods = {}, {}
      
      ##
      # This will set a class method as final.
      #
      #   class A
      #     final_class_method :method_one
      #     def self.method_one
      #       "final class method 'method_one'"
      #     end
      #   end
      #
      # Attempting to redeclare it as final class method in subclass,
      #
      #   class B < A
      #     final_class_method :method_one
      #   end
      #
      # will give you
      #
      #   FinalClassMethodRedeclarationError: cannot declare 'method_one' as final method in child B as parent A declared it already as such
      #   
      # and when,
      #   
      #   class B < A
      #     def B.method_one
      #       "'method_one' class method in B"
      #     end
      #   end
      # 
      # will give you
      # 
      #   FinalClassMethodRedefinitionError: cannot redefine 'method_one' because it is already defined as final class method in parent A.
      ##
      def final_class_methods(*method_names)
        raise_error_when_method_names_empty_or_nil(method_names)
        final_methods(@@final_singleton_methods, method_names, 'class')
      end
      alias_method :final_class_method,       :final_class_methods
      alias_method :final_singleton_methods,  :final_class_methods
      alias_method :final_singleton_method,   :final_class_methods
      
      ##
      # Returns all final singleton (class) methods. Accepts optional parameter for sorting.
      #
      #   class A
      #     final_singleton_methods :method_one, :method_two
      #     def self.method_one
      #       # any code goes here
      #     end
      #     def self.method_two
      #       # any code goes here again
      #     end
      #   end
      #
      #   class B < A
      #     final_class_method :method_three
      #     def self.method_three
      #     end
      #   end
      #
      #   B.get_final_singleton_methods
      #
      # will give you
      #
      #   [:method_one, :method_two, :method_three] # order is random
      #
      # if you will provide sort parameter, like
      #
      #   B.get_final_singleton_methods(true) # sort is true
      #
      # you will get
      #
      #   [:method_one, :method_three, :method_two]
      ##
      def get_final_singleton_methods(sorted=false)
        get_final_methods(@@final_singleton_methods, sorted)
      end
      alias_method :get_final_class_methods, :get_final_singleton_methods
      
      def final_singleton_method_exists?(method)
        final_method_exists?(@@final_singleton_methods, method)
      end
      alias_method :final_class_method_exists?, :final_singleton_method_exists?
      
      # :stopdoc:
      def singleton_method_added(method_name)
        __method_added__(@@final_singleton_methods, method_name, 'class')
      end
      # :startdoc:
      
      ##
      # This will set an instance method as final.
      #
      #   class A
      #     final_instance_method :method_two
      #     def method_two
      #       "final instance method 'method_two'"
      #     end
      #   end
      #
      # Attempting to redeclare it as final instance method in subclass,
      #
      #   class B < A
      #     final_instance_method :method_two
      #   end
      #
      # will give you
      #
      #   FinalInstanceMethodRedeclarationError: cannot declare 'method_two' as final method in child B as parent A declared it already as such
      # and when,
      #   
      #   class B < A
      #     def method_one
      #       "'method_one' class method in B"
      #     end
      #   end
      # 
      # will give you
      # 
      #   FinalInstanceMethodRedefinitionError: cannot redefine 'method_one' because it is already defined as final instance method in parent A.
      ##
      def final_instance_methods(*method_names)
        raise_error_when_method_names_empty_or_nil(method_names)
        final_methods(@@final_instance_methods, method_names, 'instance')
      end
      alias_method :final_instance_method, :final_instance_methods
      
      # :stopdoc:
      def method_added(method_name)
        __method_added__(@@final_instance_methods, method_name, 'instance')
      end
      # :startdoc:
      
      ##
      # Returns all final instance methods. Accepts optional parameter for sorting.
      #
      #   class A
      #     final_instance_methods :method_one, :method_two
      #     def method_one
      #       # any code goes here
      #     end
      #     def method_two
      #       # any code goes here again
      #     end
      #   end
      #
      #   class B < A
      #     final_instance_method :method_three
      #     def method_three
      #     end
      #   end
      #
      #   B.get_final_instance_methods
      #
      # will give you
      #
      #   [:method_one, :method_two, :method_three] # order is random
      #
      # if you will provide sort parameter, like
      #
      #   B.get_final_instance_methods(true) # sort is true
      #
      # you will get
      #
      #   [:method_one, :method_three, :method_two]
      ##
      def get_final_instance_methods(sorted=false)
        get_final_methods(@@final_instance_methods, sorted)
      end
      
      def final_instance_method_exists?(method)
        final_method_exists?(@@final_instance_methods, method)
      end
      
      private
        def final_methods(final_methods, method_names, method_type = 'class')
          validations = validate_methods(final_methods, method_names, self)
          if(validations[:valid])
            if final_methods.has_key?(self) && ((final_methods[self] - method_names) == final_methods[self])
              final_methods[self].concat(method_names.collect{|method_name| {method_name => 0}})
            else
              final_methods[self] = method_names.collect{|method_name| {method_name => 0}}
            end
          else
            final_method_error = method_type.eql?('class') ? FinalClassMethodRedeclarationError : FinalInstanceMethodRedeclarationError
            raise final_method_error.new(validations[:error_message])
          end
        end

        def __method_added__(final_methods, method_name, method_type='class')
          # once final method added is added already to parent(not equal self),
          # then remove method in current contetxt (self)
          if (parent = get_class_of_final_method(final_methods, method_name))
            if method_type.eql?("class")
              eval %Q{class << #{self}\nremove_method "#{method_name}"\nend}
            else
              remove_method method_name
            end
            final_method_error = method_type.eql?('class') ? FinalClassMethodRedefinitionError : FinalInstanceMethodRedefinitionError
            raise final_method_error.new("cannot redefine '#{method_name}' because it is already defined as final #{method_type} method in parent #{parent}.")
          else
            unless(parent = get_class_of_final_method(final_methods, method_name, true)).nil?
              increment_final_method_definition_count(final_methods[parent], method_name)
              if((final_method_definition_count(final_methods[parent], method_name)) > 1) && method_type.eql?('class')
                final_method_error = method_type.eql?('class') ? FinalClassMethodRedefinitionError : FinalInstanceMethodRedefinitionError
                raise final_method_error.new("redefining class method '#{method_name}' in same class but inside child class will yield erroneous effect.")
                exit
              end
            end
          end
        end
        
        def get_class_of_final_method(final_methods, method_name, equal_to_self = false)
          final_methods.each_key do |key|
            if method_declared_already_as_final?(final_methods[key], method_name) && (equal_to_self ? (key == self) : (key != self))
              return key
            end
          end
          nil
        end
        
        def method_declared_already_as_final?(method_names, method_name)
          method_names.each do |mn|
            return true if mn.has_key?(method_name)
          end
          false
        end
        
        def increment_final_method_definition_count(method_names, method_name)
          method_names.each do |mn|
            mn[method_name] +=1 if mn.has_key?(method_name)
          end
        end
        
        def final_method_definition_count(method_names, method_name)
          method_names.each do |mn|
            return mn[method_name] if mn.has_key?(method_name)
          end
        end
        
        def validate_methods(final_methods, methods, context)
          validation = {}
          methods.each do |method|
            validation[method] = get_class_of_final_method(final_methods, method)
          end
          
          message_for_invalidity = []
          validation.each do |key, parent|
            if parent
              message_for_invalidity << "cannot declare '#{key}' as final method in child #{context} as parent #{parent} declared it already as such." 
            end
          end
          
          {:valid => (message_for_invalidity.empty?), :error_message => (message_for_invalidity.empty? ? '' : message_for_invalidity.join("\n"))}
        end
        
        def get_final_methods(final_methods, sorted=false)
          fm = []
          get_subclass_range.each do |_class|
            if final_methods[_class]
              final_methods[_class].each do |method|
                fm.concat method.keys
              end
            end
          end
          fm.sort!{|a, b| a.to_s <=> b.to_s} if sorted
          fm
        end
        
        def get_subclass_range
          _ancestors = self.ancestors
          _ancestors.each do |a|
            if self.eql?(a)
              break
            else
              _ancestors.shift
            end
          end
          _ancestors
        end
        
        def final_method_exists?(final_methods, method)
          raise_error_when_argument_not_symbol(method)
          ret, subclass_range = false, get_subclass_range
          final_methods.each do |key,value|
            if subclass_range.include?(key)
              value.each do |m|
                return true if m.has_key?(method)
              end
            end
          end
          ret
        end

        def raise_error_when_method_names_empty_or_nil(method_names)
          raise ArgumentError.new("methods arguments missing.") if (method_names.empty? || method_names.nil?)
        end
        
        def raise_error_when_argument_not_symbol(method)
          raise ArgumentError.new("incorrect method argument type. It must be symbol") unless method.is_a?(Symbol)
        end
    end
  end
end