# frozen_string_literal: true

module Validation
  def valid?
    validation!
  rescue StandardError
    false
  end
end
