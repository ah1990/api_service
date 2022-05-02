# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::StocksController, type: :request do
  let(:stock) { create :stock }
  let(:headers) {{ "ACCEPT" => "application/json" }}

  before do
    stock
  end

  it 'should get stocks list' do
    get '/api/v1/stocks', headers: headers
    expect(response).to be_successful

    expect(json_body[:stocks].size).to eq 1
  end

  it 'should get current stock' do
    get "/api/v1/stocks/#{stock.id}", headers: headers
    expect(response).to be_successful

    expect(json_body[:stock][:name]).to eq stock.name
    expect(json_body[:stock][:bearer][:name]).to eq stock.bearer.name
  end

  it 'should not get stock' do
    stock_id = "test#{stock.id}"

    delete "/api/v1/stocks/#{stock_id}", headers: headers
    expect(response).to be_unprocessable

    expect(json_body[:entity]).to eq "Stock"
    expect(json_body[:errors].include?("Stock with id: #{stock_id} doesn't exists.")).to be_truthy
  end

  it 'should update stock' do
    params = { name: 'Updated name' }

    patch "/api/v1/stocks/#{stock.id}", params: params, headers: headers
    expect(response).to be_successful

    expect(json_body[:stock][:name]).to eq params[:name]
  end

  it 'should not update stock' do
    stock_id = "test#{stock.id}"

    delete "/api/v1/stocks/#{stock_id}", headers: headers
    expect(response).to be_unprocessable

    expect(json_body[:entity]).to eq "Stock"
    expect(json_body[:errors].include?("Stock with id: #{stock_id} doesn't exists.")).to be_truthy
  end

  it 'should soft destroy stock' do
    delete "/api/v1/stocks/#{stock.id}", headers: headers
    expect(response).to be_successful

    expect(Stock.without_deleted.size).to eq 0
  end

  it 'should not destroy stock' do
    stock_id = "test#{stock.id}"

    delete "/api/v1/stocks/#{stock_id}", headers: headers
    expect(response).to be_unprocessable

    expect(json_body[:entity]).to eq "Stock"
    expect(json_body[:errors].include?("Stock with id: #{stock_id} doesn't exists.")).to be_truthy
  end

  it 'should create new stock' do
    params = { name: 'Stock name on create', bearer: { name: 'New bearer' } }

    post '/api/v1/stocks', params: params, headers: headers
    expect(response).to be_created

    expect(json_body[:stock][:name]).to eq params[:name]
    expect(json_body[:stock][:bearer][:name]).to eq params[:bearer][:name]
    expect(Stock.without_deleted.size).to eq 2
  end

  it 'should not create new stock' do
    params = { name: stock.name, bearer: { name: 'New bearer' } }

    post '/api/v1/stocks', params: params, headers: headers
    expect(response).to be_unprocessable

    expect(json_body[:entity]).to eq stock.class.name
    expect(json_body[:errors].include?("Name has already been taken")).to be_truthy
    expect(Stock.without_deleted.size).to eq 1
  end
end