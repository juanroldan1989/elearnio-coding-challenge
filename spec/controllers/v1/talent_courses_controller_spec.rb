require "rails_helper"

RSpec.describe V1::TalentCoursesController, type: :controller do
  describe "POST #create" do
    let!(:talent) { create(:talent) }
    let!(:course) { create(:course, author: create(:author)) }

    context "with valid params" do
      let(:valid_params) { { talent_id: talent.id, course_id: course.id } }

      it "should return proper message" do
        post :create, params: { talent_course: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["message"]).to eq "Talent ##{talent.id} assigned Course ##{course.id}"
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { talent_id: "", course_id: 1 } }

      it "should not create record" do
        post :create, params: { talent_course: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["message"]).to eq ["Talent must exist", "Course must exist"]
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:talent) { create(:talent) }
    let!(:course) { create(:course, author: create(:author)) }
    let!(:talent_course) { create(:talent_course, talent: talent, course: course) }

    it "should return proper message" do
      delete :destroy, params: { talent_id: talent.id, course_id: course.id }

      response_body = JSON.parse(response.body)

      expect(response_body["message"]).to eq "Talent ##{talent.id} removed from Course ##{course.id}"
    end
  end
end
