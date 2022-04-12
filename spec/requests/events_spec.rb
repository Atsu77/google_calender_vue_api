require 'rails_helper'

RSpec.describe 'Events', type: :request do
  describe 'GET /events' do
    it 'イベント一覧が取得できる' do
      get '/events'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id' do
    context 'idが存在する場合' do
      it 'イベント詳細が取得できる' do
        get '/events/1'
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /events' do
    context 'パラメータが妥当な場合' do
      it 'イベントが作成できる' do
        post '/events',
             params: { event: { name: 'test', start: '2020-01-01', end: '2020-01-01' } }
        expect(response).to have_http_status(201)
      end
    end
    context 'パラメータが不正な場合' do
      it 'イベントが作成できない' do
        name = 'a'*101 # nameが100文字以上の場合, イベントが作成できない
        post '/events',
             params: { event: { name: name, start: '2020-01-01', end: '2020-01-01' } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PATCH /events/:id' do
    context 'パラメータが妥当な場合' do
      it 'イベントが更新できる' do
        put '/events/1',
            params: { event: { name: 'name_after_update', start: '2020-01-01', end: '2020-01-01' } }
        expect(response).to have_http_status(200)
      end
    end
    context 'パラメータが不正な場合' do
      it 'イベントが更新できない' do
        name = 'a'*101 # nameが100文字以上の場合, イベントが更新できない
        put '/events/1',
             params: { event: { name: name, start: '2020-01-01', end: '2020-01-01' } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /events/:id' do
    it 'イベントが削除できる' do
      delete '/events/1'
      expect(response).to have_http_status(200)
    end
  end
end
