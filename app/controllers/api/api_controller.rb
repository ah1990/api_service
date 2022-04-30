# frozen_string_literal: true

class Api::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error

  private

  def record_invalid_error(e)
    message = e.record.respond_to?(:errors) ? e.record.errors.to_a : e.message
    render_error(e.record.class.name, message, :unprocessable_entity)
  end
end