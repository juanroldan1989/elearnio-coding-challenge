require "rails_helper"

RSpec.describe V1::TalentsController, type: :controller do
  describe "GET #index" do
    let!(:talent_1) { create(:talent) }
    let!(:talent_2) { create(:talent) }

    context "API V1 response body" do
      it "should return talents collection" do
        get :index

        response_body = JSON.parse(response.body)

        expect(response_body.size).to eq Talent.count
        expect(response_body.first["first_name"]).to eq talent_1.first_name
        expect(response_body.first["last_name"]).to eq talent_1.last_name
        expect(response_body.second["first_name"]).to eq talent_2.first_name
        expect(response_body.second["last_name"]).to eq talent_2.last_name
      end

      it "should return 200 status code" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { first_name: "John", last_name: "Talent" } }

      it "should return record created" do
        post :create, params: { talent: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent"]["first_name"]).to eq valid_params[:first_name]
        expect(response_body["talent"]["last_name"]).to eq valid_params[:last_name]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { first_name: "", last_name: "Talent" } }

      it "should not create record" do
        post :create, params: { talent: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent"]).to eq nil
        expect(response_body["message"]).to eq ["First name can't be blank"]
      end
    end
  end

  describe "PUT #update" do
    let!(:talent) { create(:talent) }

    context "with valid params" do
      let(:valid_params) { { first_name: "John" } }

      it "should return record updated" do
        put :update, params: { id: talent.id, talent: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent"]["first_name"]).to eq valid_params[:first_name]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { first_name: nil } }

      it "should not update record" do
        put :update, params: { id: talent.id, talent: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent"]["first_name"]).to eq talent.first_name
        expect(response_body["message"]).to eq ["First name can't be blank"]
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:talent) { create(:talent) }

    it "should return proper message" do
      delete :destroy, params: { id: talent.id }

      response_body = JSON.parse(response.body)

      expect(response_body["message"]).to eq "Talent deleted"
    end
  end
end
