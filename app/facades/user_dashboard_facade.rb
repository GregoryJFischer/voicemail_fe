class UserDashboardFacade

  def initialize(user_id)
    @user = BackendService.get_user(user_id)
    @representatives = BackendService.representatives(user_id)
  end

  def user
    UserBe.new(@user)
  end

  def representatives
    @representatives.map do |rep|
      Representative.new(rep)
    end
  end
end
