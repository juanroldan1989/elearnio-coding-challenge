require "rails_helper"

RSpec.describe V1::TalentLearningPathCoursesController, type: :controller do
  describe "POST #create" do
    let!(:talent) { create(:talent) }
    let!(:learning_path) { create(:learning_path) }
    let!(:course) { create(:course, author: create(:author)) }

    context "with valid params" do
      let(:valid_params) { {
        talent_id: talent.id,
        learning_path_id: learning_path.id,
        course_id: course.id
      } }

      it "should return record created" do
        post :create, params: { talent_learning_path_course: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent_learning_path_course"]["talent_id"]).to eq valid_params[:talent_id]
        expect(response_body["talent_learning_path_course"]["learning_path_id"]).to eq valid_params[:learning_path_id]
        expect(response_body["talent_learning_path_course"]["course_id"]).to eq valid_params[:course_id]
        expect(response_body["talent_learning_path_course"]["course_status"]).to eq TalentLearningPathCourse::STAND_BY
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { talent_id: "", learning_path_id: "", course_id: "" } }

      it "should not create record" do
        post :create, params: { talent_learning_path_course: invalid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent_learning_path_course"]).to eq nil
        expect(response_body["message"]).to eq ["Talent can't be blank", "Learning path can't be blank", "Talent must exist", "Learning path must exist", "Course must exist"]
      end
    end
  end

  describe "PUT #update" do
    let!(:talent) { create(:talent) }
    let!(:learning_path) { create(:learning_path) }
    let!(:course_1) { create(:course, author: create(:author)) }
    let!(:course_2) { create(:course, author: create(:author)) }
    let!(:learning_path_course) { create(:learning_path_course, learning_path: learning_path, course: course_1) }
    let!(:learning_path_course) { create(:learning_path_course, learning_path: learning_path, course: course_2) }

    let!(:talent_learning_path_course) {
      create(:talent_learning_path_course,
        talent: talent,
        learning_path: learning_path,
        course: course_1
      )
    }

    context "when a talent updates a course in a learning path to IN_PROGRESS" do
      let(:valid_params) { {
        course_status: TalentLearningPathCourse::IN_PROGRESS
      } }

      it "should return record updated" do
        put :update, params: { id: talent_learning_path_course.id, talent_learning_path_course: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent_learning_path_course"]["course_id"]).to eq course_1.id
        expect(response_body["talent_learning_path_course"]["course_status"]).to eq TalentLearningPathCourse::IN_PROGRESS
      end
    end

    context "when a talent updates a course in a learning path to COMPLETED" do
      let(:valid_params) { {
        course_status: TalentLearningPathCourse::COMPLETED
      } }

      it "should get assigned the next course in the learning path" do
        put :update, params: { id: talent_learning_path_course.id, talent_learning_path_course: valid_params }

        response_body = JSON.parse(response.body)

        expect(response_body["talent_learning_path_course"]["course_id"]).to eq course_2.id
        expect(response_body["talent_learning_path_course"]["course_status"]).to eq TalentLearningPathCourse::STAND_BY
      end

      it "should create new TalentLearningPathCourse record with next course in the learning path" do
        expect {
          put :update, params: { id: talent_learning_path_course.id, talent_learning_path_course: valid_params }
        }.to change { TalentLearningPathCourse.count }.by(1)

        new_record = TalentLearningPathCourse.last

        expect(new_record.course.id).to eq course_2.id
        expect(new_record.course_status).to eq TalentLearningPathCourse::STAND_BY
      end

      context "and learning path does not have more courses" do
        let!(:learning_path_2) { create(:learning_path) }
        let!(:course_3) { create(:course, author: create(:author)) }
        let!(:learning_path_course) {
          create(:learning_path_course, learning_path: learning_path_2, course: course_3)
        }

        let!(:talent_learning_path_course_2) {
          create(:talent_learning_path_course,
            talent: talent,
            learning_path: learning_path_2,
            course: course_3
          )
        }

        it "should not create new TalentLearningPathCourse record" do
          expect {
            put :update, params: { id: talent_learning_path_course_2.id, talent_learning_path_course: valid_params }
          }.not_to change { TalentLearningPathCourse.count }
        end

        it "should return error message" do
          put :update, params: { id: talent_learning_path_course_2.id, talent_learning_path_course: valid_params }

          response_body = JSON.parse(response.body)

          expect(response_body["talent_learning_path_course"]["id"]).to eq nil
          expect(response_body["message"]).to eq ["Learning path does not have any more courses to proceed with"]
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:talent) { create(:talent) }
    let!(:learning_path) { create(:learning_path) }
    let!(:course) { create(:course, author: create(:author)) }

    let!(:talent_learning_path_course) {
      create(:talent_learning_path_course,
        talent: talent,
        learning_path: learning_path,
        course: course
      )
    }

    it "should return proper message" do
      delete :destroy, params: { id: talent_learning_path_course.id }

      response_body = JSON.parse(response.body)

      expect(response_body["message"]).to eq "Record deleted"
    end
  end
end
