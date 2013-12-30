class ArticleDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  #
  TIMESTAMPS = [:created_at, :updated_at]

  def as_json(options = {})
    if context[:role] == :admin
      object.as_json
    else
      object.as_json(only: :title)
    end
  end

  def to_xml(options = {})
    if context[:role] == :admin
      object.to_xml
    elsif context[:role] == :trusted
      object.to_xml(:except => TIMESTAMPS)
    else
      object.to_xml(:only => [:title, :body])
    end
  end
end
