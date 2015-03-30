class Admin::SortUsers
  attr_accessor :attr, :direction
  DEFAULT_ATTR = 'id'
  DEFAULT_DIRECTION = 'asc'

  def initialize(attr, direction)
    @attr = attr
    @direction = direction
  end

  def scope
    User.order("#{sorting_column_name} #{sorting_direction}")
  end

  def sorting_column_name
    {
      'email' => 'email',
      'id' => 'id',
    }.fetch(attr, DEFAULT_ATTR)
  end

  def sorting_direction
    %w(asc desc).include?(direction) ? direction : DEFAULT_DIRECTION
  end
end