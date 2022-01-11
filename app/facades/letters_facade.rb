class LettersFacade
  def self.create_letter(body, user_id)
    user_body = BackendService.get_user(user_id)
    user_attributes = user_body[:data]
    rep_body = BackendService.representatives(user_id)

    #This line needs to be updated once we have our reps page up and running
    rep_attributes = rep_body[:data][11]

    letter = Letter.new(rep_attributes, user_attributes, body)
    response = BackendService.post("letters", letter.attributes)
    confirmation = BackendService.parse_response(response)
  end
end
