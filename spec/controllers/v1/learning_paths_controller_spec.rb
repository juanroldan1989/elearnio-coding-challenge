require "rails_helper"

RSpec.describe V1::LearningPathsController, type: :controller do
  describe "GET #index" do
    let!(:learning_path) { create(:learning_path) }

    context "API V1 response body" do
      it "should return learning_paths collection" do
        get :index

        response_body = JSON.parse(response.body)

        expect(response_body.size).to eq LearningPath.count
        expect(response_body.first["title"]).to eq learning_path.title
        expect(response_body.first["description"]).to eq learning_path.description
      end

      it "should return 200 status code" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST #create" do
    let!(:course) { create(:course, author: create(:author)) }

    # A learning path can have 1 to n courses
    context "with valid params and providing at least 1 course" do
      let(:valid_params) { {
        title: "Sample LearningPath Title",
        description: "Sample description for LearningPath"
      } }

      it "should return record created" do
        post :create, params: { learning_path: valid_params, course_ids: [course.id] }

        response_body = JSON.parse(response.body)

        expect(response_body["learning_path"]["title"]).to eq valid_params[:title]
        expect(response_body["learning_path"]["description"]).to eq valid_params[:description]
        expect(response_body["courses"][0]["id"]).to eq course.id
      end
    end

    context "with invalid title" do
      let(:invalid_params) { {
        title: "",
        description: "Sample description for the LearningPath"
      } }

      it "should not create record" do
        post :create, params: { learning_path: invalid_params, course_ids: [course.id] }

        response_body = JSON.parse(response.body)

        expect(response_body["learning_path"]).to eq nil
        expect(response_body["message"]).to eq ["Title can't be blank"]
      end
    end

    context "without course IDs" do
      let(:valid_params) { {
        title: "Sample Title",
        description: "Sample description for the LearningPath"
      } }

      it "should not create record" do
        post :create, params: { learning_path: valid_params, course_ids: [] }

        response_body = JSON.parse(response.body)

        expect(response_body["learning_path"]).to eq nil
        expect(response_body["message"]).to eq ["Course ids required to create LearningPath record"]
      end
    end
  end

  describe "PUT #update" do
    let!(:learning_path) { create(:learning_path) }

    context "with valid params" do
      let(:valid_params) { { title: "Another title" } }

      it "should return record updated" do
        put :update, params: { id: learning_path.id, learning_path: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["learning_path"]["title"]).to eq valid_params[:title]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { title: nil } }

      it "should not update record" do
        put :update, params: { id: learning_path.id, learning_path: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["learning_path"]["title"]).to eq learning_path.title
        expect(response_body["message"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:learning_path) { create(:learning_path) }

    it "should return proper message" do
      delete :destroy, params: { id: learning_path.id }

      response_body = JSON.parse(response.body)

      expect(response_body["message"]).to eq "LearningPath deleted"
    end
  end
end
