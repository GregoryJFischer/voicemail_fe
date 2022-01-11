class LettersFacade
  def self.create_letter(body, user_id, rep_attributes)
    user_body = BackendService.get_user(user_id)
    user_attributes = user_body[:data]
    rep_body = BackendService.representatives(user_id)

    #This line needs to be updated once we have our reps page up and running
    binding.pry
    letter = Letter.new(rep_attributes, user_attributes, body)
    response = BackendService.post("letters", letter.attributes)
    BackendService.parse_response(response)
  end
end
