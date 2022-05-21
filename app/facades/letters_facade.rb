class LettersFacade
  def self.create_letter(body, user_id, rep_attributes)
    user_body = BackendService.get_user(user_id)
    user_attributes = user_body[:data]

    letter = Letter.new(rep_attributes, user_attributes, body)
    letter
    BackendService.create_letter(letter_attributes: letter.attributes)
  end

  def self.preview_letter(body, user_id, rep_attributes)
    user_body = BackendService.get_user(user_id)
    user_attributes = user_body[:data]

    letter = Letter.new(rep_attributes, user_attributes, body)
    BackendService.preview_letter(letter_attributes: letter.attributes)
  end
end
