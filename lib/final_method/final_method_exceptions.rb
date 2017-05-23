# Base error class for FinalMethod module
class FinalMethodError < StandardError
end

# Raised when final class method defined in parent class
# is attempted to be redefined in child class as final class method.
class FinalClassMethodRedefinitionError < FinalMethodError
end

# Raised when final class method declared in parent class
# is attempted to be redeclared in child class as final class method.
class FinalClassMethodRedeclarationError < FinalMethodError
end

# Raised when final instance method defined in parent class
# is attempted to be redefined in child class as final instance method.
class FinalInstanceMethodRedefinitionError < FinalMethodError
end

# Raised when final instance method declared in parent class
# is attempted to be redeclared in child class as final instance method.
class FinalInstanceMethodRedeclarationError < FinalMethodError
end