require "rails_helper"

RSpec.describe V1::AuthorsController, type: :controller do
  describe "GET #index" do
    let!(:author_1) { create(:author) }
    let!(:author_2) { create(:author) }

    context "API V1 response body" do
      it "should return authors collection" do
        get :index

        response_body = JSON.parse(response.body)

        expect(response_body.size).to eq Author.count
        expect(response_body.first["first_name"]).to eq author_1.first_name
        expect(response_body.first["last_name"]).to eq author_1.last_name
        expect(response_body.second["first_name"]).to eq author_2.first_name
        expect(response_body.second["last_name"]).to eq author_2.last_name
      end

      it "should return 200 status code" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { first_name: "John", last_name: "author" } }

      it "should return record created" do
        post :create, params: { author: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["author"]["first_name"]).to eq valid_params[:first_name]
        expect(response_body["author"]["last_name"]).to eq valid_params[:last_name]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { first_name: "", last_name: "author" } }

      it "should not create record" do
        post :create, params: { author: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["author"]).to eq nil
        expect(response_body["message"]).to eq ["First name can't be blank"]
      end
    end
  end

  describe "PUT #update" do
    let!(:author) { create(:author) }

    context "with valid params" do
      let(:valid_params) { { first_name: "John" } }

      it "should return record updated" do
        put :update, params: { id: author.id, author: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["author"]["first_name"]).to eq valid_params[:first_name]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { first_name: nil } }

      it "should not update record" do
        put :update, params: { id: author.id, author: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["author"]["first_name"]).to eq author.first_name
        expect(response_body["message"]).to eq ["First name can't be blank"]
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:author_1) { create(:author) }
    let!(:author_2) { create(:author) }
    let!(:course_1) { create(:course, author_id: author_1.id)}
    let!(:course_2) { create(:course, author_id: author_1.id)}

    it "should transfer courses to another author" do
      expect(course_1.author_id).to eq author_1.id
      expect(course_2.author_id).to eq author_1.id

      delete :destroy, params: { id: author_1.id }

      response_body = JSON.parse(response.body)

      expect(response_body["message"]).to eq "Author deleted"
      expect(course_1.reload.author_id).to eq author_2.id
      expect(course_2.reload.author_id).to eq author_2.id
    end
  end
end
