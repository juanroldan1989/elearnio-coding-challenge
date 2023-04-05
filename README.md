# Elearnio Coding Challenge

You are responsible for implementing a new API.

The customer requires an app that handles learning paths, courses, course authors and talents.

The API includes CRUD operations for all these items.

The development team already established which language/platform is going to be used the app should use Ruby on Rails 6.0 on the backend and access a Postgres database.

Since it is a prototype, no frontend is required.

Requirements:

1. No authentication methods for this prototype
2. A talent can be assigned to 0 to n courses
3. A talent can be assigned to 0 to n learning paths
4. An author can have 0 to n courses
5. A talent in one course can be the author of another course
6. When deleting an author, the course has to be transferred to another author
7. A learning path can have 1 to n courses, which are ordered in sequence
8. A course can have 0 to n talents and must have 1 author
9. When a talent completes a course in a learning path, they get assigned the
   next course in the learning path
   Definition of done for this challenge:

- Client can CRUD the data on the API
- Client can mark a course completed for a talent
- No errors
- Rspec for testing
- Documentation where applicable
