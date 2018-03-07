require 'rails_helper'

describe "/todos" do
  def response_json
    JSON.parse(response.body) if response.body.present?
  end

  describe "POST /" do
    let(:todo) { { title: 'Go to the store', complete: false } }
    let(:headers) { { "Content-Type" => "application/json" } }

    it "creates a todo" do
      expect do
        post "/todos", params: todo.to_json, headers: headers
      end.to change { Todo.count }.by 1

      expect(response_json).to have_key 'title'
      expect(response_json['title']).to eq 'Go to the store'

      expect(response_json).to have_key 'complete'
      expect(response_json['complete']).to eq false
    end
  end

  describe 'GET /' do
    let!(:todos) { create_list :todo, 2 }

    it "gets a list of todos" do
      get "/todos", headers: headers

      expect(response_json.size).to eq 2
    end

    it "doesn't get archived items" do
      innactive_todo = create :todo, active: false

      get "/todos", headers: headers

      expect(response_json.size).to eq 2
    end
  end

  describe 'DELETE /:id' do
    let!(:todo) { create :todo }

    it "destroys the todo" do
      expect do
        delete "/todos/#{todo.id}", headers: headers
      end.to change {Todo.active.size}.by(-1)
    end
  end
end
