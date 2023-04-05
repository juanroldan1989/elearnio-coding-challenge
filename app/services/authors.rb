class Authors
  def self.delete(author_id)
    courses = Course.where(author_id: author_id)

    if courses.any?
      begin
        Author.destroy(author_id)
        courses.each { |course| course.update(author_id: Author.first.id) }
      rescue StandardError => e
        e.message
      end
    end

    "Author deleted"
  end
end
