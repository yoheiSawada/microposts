module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end
    
    def store_location
         session[:forwarding_url] = request.url if request.get?
    end
end


#||=は左の値がfalseかnilの場合に右の値の代入を行います。
#変数を初期化する際によく用いる
##@current_user = @current_user || User.find_by(id: session[:user_id])と読み替えることができ、
##@current_userがnilのときに、User.find_by(id: session[:user_id])を実行します。
##◦User.find_by(id: session[:user_id])は、session[:user_id]の値に一致するユーザーを返します。
##find_byメソッドは、ユーザーが見つからない場合はnilを返します。
##したがって、session[:user_id]に一致するユーザーが存在する場合は@current_userにログイン中のユーザー（現在のユーザー）が入り、nilの場合は@current_userにnilが入ります。
##メソッド中の最後の値が代入文の場合は、代入文を実行した後の左の値を返すので、current_userメソッドは@current_userの値を返します。
##||=で代入を行っているので、左側の@current_userに値が入っている場合は、右側のUser.find_byで始まる処理は実行されません。すなわち、ログインしているユーザーを毎回DBに取りに行かなくてすみます。


##logged_in?メソッドでは以下のようなことを行っています。
##current_userが存在する場合はtrueを、nilの場合はfalseを返します。 ◦!!は、右側に続く値が存在する場合はtrueを、nilの場合はfalseを返します。
##これは、否定演算子!を二回つかったものと考えることができます。 ◾current_userが存在する場合、!current_userがfalseになり、もう一度!をつけるとfalseが反転してtrueになります。
##urrent_userがnilの場合、!current_userがtrueになり、もう一度!をつけるとtrueが反転してfalseになります。



##store_locationメソッドでは以下のようなことを行っています。
##リクエストがGETの場合は、session[:forwarding_url]にリクエストのURLを代入しています。
##ログインが必要なページにアクセスしようとした際に、ページのURLを一旦保存しておき、ログイン画面に遷移してログイン後に再び保存したURLにアクセスする場合にこのメソッドを使用します。
