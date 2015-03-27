# Add method to sanitize parameters for constantize

class String
  def sanitize_constant(klass_list=[])
    klass_list.each do |klass|
      return self.constantize if self == klass.to_s
    end
    raise "Can't constantize #{self}!!"
  end
end
