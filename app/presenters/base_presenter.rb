class BasePresenter
  include ActionView::Helpers
  attr_reader :object
  
  def initialize(object, template = nil)
    @object = object
    @template = template
  end

private

  def h
    @template
  end
  
  def method_missing(*args, &block)
    @object.send(*args, &block)
  end
end