class LearningPaths
  def self.create(attributes)

    # A learning path can have 1 to n courses
    begin
      if attributes[:course_ids].blank?
        raise "required to create LearningPath record"
      end

      learning_path = LearningPath.create(
        title: attributes[:title],
        description: attributes[:description]
      )

      attributes[:course_ids].each do |course_id|
        LearningPathCourse.create(
          learning_path_id: learning_path.id,
          course_id: course_id
        )
      end
    rescue StandardError => e
      learning_path = LearningPath.new
      learning_path.errors.add(:course_ids, e.message)
    end

    learning_path
  end
end
