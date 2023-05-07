class ApplicationController < ActionController::Base
 include SessionsHelper #SessionsHelperで書いた便利メソッドがApplicationControllerで展開される
                        #=>ApplicationControllerを継承しているすべてのControllerで使える
end
