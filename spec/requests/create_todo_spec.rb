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

    it "sets the id of a todo" do
      id = SecureRandom.uuid
      todo = attributes_for :todo, id: id

      expect do
        post "/todos", params: todo.to_json, headers: headers
      end.to change { Todo.count }.by 1

      expect(response_json).to have_key 'id'
      expect(response_json['id']).to eq id
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

  describe 'PUT /:id' do
    let(:headers) { { "Content-Type" => "application/json" } }
    let!(:todo) { create :todo }
    let(:title) { "my new title" }

    it 'updates a todo title' do
      updated_params = todo.as_json.merge(title: title)
      expect do
        put "/todos/#{todo.id}", params: updated_params.to_json, headers: headers
      end.to change {todo.reload.title }.to(title)
    end

    it 'updates a todo title' do
      todo = create :todo, active: false
      expect do
        put "/todos/#{todo.id}", headers: headers
      end.to change {todo.reload.active }.to(true)
    end

    it 'updates a todo complete' do
      updated_params = todo.as_json.merge(complete: true)
      expect do
        put "/todos/#{todo.id}", params: updated_params.to_json, headers: headers
      end.to change {todo.reload.complete }.to(true)
    end

    it 'dones not update a todo id' do
      id = SecureRandom.uuid
      updated_params = todo.as_json.merge(id: id)
      put "/todos/#{todo.id}", params: updated_params.to_json, headers: headers

      expect(Todo.find_by_id(id)).to be_nil
      expect(Todo.find_by_id(todo.id)).not_to be_nil
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
