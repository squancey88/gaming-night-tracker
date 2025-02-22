# frozen_string_literal: true

class Layout::SystemAdminMenuComponent < ViewComponent::Base
  delegate :current_user, :emulated, to: :helpers

  def render?
    current_user&.is_admin? || session[:original_user_id].present?
  end
end
