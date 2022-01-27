class UserDashboardFacade
  def initialize(user_id)
    @user = BackendService.get_user(user_id)
  end

  def user
    UserBe.new(@user)
  end

  def representatives
    representative_service[:data].map do |rep|
      Representative.new(rep)
    end
  end

  def representative_service
    BackendService.representatives(@user[:data][:id]) if user.address_line1
  end
end
