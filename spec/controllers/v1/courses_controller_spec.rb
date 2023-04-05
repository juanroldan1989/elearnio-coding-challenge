require "rails_helper"

RSpec.describe V1::CoursesController, type: :controller do
  describe "GET #index" do
    let!(:course) { create(:course) }

    context "API V1 response body" do
      it "should return courses collection" do
        get :index

        response_body = JSON.parse(response.body)

        expect(response_body.size).to eq Course.count
        expect(response_body.first["title"]).to eq course.title
        expect(response_body.first["description"]).to eq course.description
        expect(response_body.first["author_id"]).to eq course.author_id
      end

      it "should return 200 status code" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { {
        title: "Sample Course Title",
        description: "Sample description for course",
        author_id: 1
      } }

      it "should return record created" do
        post :create, params: { course: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["course"]["title"]).to eq valid_params[:title]
        expect(response_body["course"]["description"]).to eq valid_params[:description]
        expect(response_body["course"]["author_id"]).to eq valid_params[:author_id]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { {
        title: "",
        description: "Sample description for the course",
        author_id: 1
      } }

      it "should not create record" do
        post :create, params: { course: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["course"]).to eq nil
        expect(response_body["message"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "PUT #update" do
    let!(:course) { create(:course) }

    context "with valid params" do
      let(:valid_params) { { title: "Another title" } }

      it "should return record updated" do
        put :update, params: { id: course.id, course: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["course"]["title"]).to eq valid_params[:title]
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { title: nil } }

      it "should not update record" do
        put :update, params: { id: course.id, course: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["course"]["title"]).to eq course.title
        expect(response_body["message"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:course) { create(:course) }

    it "should return proper message" do
      delete :destroy, params: { id: course.id }

      response_body = JSON.parse(response.body)

      expect(response_body["message"]).to eq "Course deleted"
    end
  end
end
