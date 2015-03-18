class BaseDecorator < SimpleDelegator
  include ActionView::Helpers

  def self.wrap(collection)
    collection.map do |object|
        new object
    end
  end

  def model
    __getobj__
  end
end
