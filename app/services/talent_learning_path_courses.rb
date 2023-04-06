class TalentLearningPathCourses
  def self.update_status(id, record_params)
    record = TalentLearningPathCourse.find(id)
    record.update(record_params)
    record.reload

    if record.course_status == 2
      begin
        learning_path = record.learning_path
        current_course = record.course

        # it should get assigned the next course in the learning path
        next_course = learning_path.courses.find_by_id(current_course.id + 1)

        if next_course.present?
          # persists data in new record
          record = TalentLearningPathCourse.create(
            talent_id: record.talent_id,
            learning_path_id: record.learning_path_id,
            course_id: next_course.id,
            course_status: 0
          )
        else
          record = TalentLearningPathCourse.new
          record.errors.add(:learning_path, "does not have any more courses to proceed with")
        end

        record
      rescue StandardError => e
        e.message
      end
    end

    record
  end
end
