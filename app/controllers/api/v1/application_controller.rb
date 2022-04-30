# frozen_string_literal: true

class Api::V1::ApplicationController < Api::ApiController

  protected

  def render_error(entity, messages, status)
    render json: { entity: entity, errors: messages }, status: status
  end
end