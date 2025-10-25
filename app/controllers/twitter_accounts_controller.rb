class TwitterAccountsController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @twitter_accounts =  Current.user.twitter_accounts
  end

  def destroy
    @twitter_account = Current.user.twitter_accounts.find_by(id: params[:id])
    if @twitter_account
      @twitter_account.destroy
      redirect_to twitter_accounts_path, notice: "Twitter account disconnected @#{@twitter_account.username}"
    else
      redirect_to twitter_accounts_path, alert: "Account not found"
    end
  end
end
