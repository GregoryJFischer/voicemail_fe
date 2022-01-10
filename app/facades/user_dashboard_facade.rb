class UserDashboardFacade

  def initialize(user_id)
    @user = BackendService.get_user(user_id)
    # @representatives = BackendService.representatives(user_id)
  end

  def user
    UserBe.new(@user)
  end

  def representatives
    representative_service.map do |rep|
      Representative.new(rep)
    end
  end

  def representative_service
    if user.address_line1
      BackendService.representatives(user.id)
    else
      nil
    end
  end
end
