class UserMailer < ActionMailer::Base
  default from: "no-reply@myservicetrac.com"
  
  def sendpassword(user,protocol, host)
        @user =user
        @password=user.plain_password
        @protocol = protocol
        @host = host
        mail(:to => user.email, :subject => "Recover Password")
  end
end
