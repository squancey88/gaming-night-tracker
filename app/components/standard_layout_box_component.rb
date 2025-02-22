# frozen_string_literal: true

class StandardLayoutBoxComponent < ViewComponent::Base
  renders_one :body
  renders_one :menu

  def initialize(title: nil, classes: [], height_limited: true)
    @title = title
    @classes = classes
    @height_limited = height_limited
  end

  def box_classes
    (["card", "text-bg-light"] + @classes).join(" ")
  end

  def content_classes
    classes = %w[standard-box_content card-body]
    classes << "height-limited" if @height_limited
    classes.join(" ")
  end
end
