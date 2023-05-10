class ApplicationController < ActionController::Base
 include SessionsHelper #SessionsHelperで書いた便利メソッドがApplicationControllerで展開される
                        #=>ApplicationControllerを継承しているすべてのControllerで使える
                        
  private
   
   # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
         redirect_to login_url
      end
    end
end
