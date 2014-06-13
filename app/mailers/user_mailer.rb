class UserMailer < ActionMailer::Base
  default from: "mss.naveensharma@gmail.com"
  
  def sendpassword(user,protocol, host)
        @user =user
        @password=user.plain_password
        @protocol = protocol
        @host = host
        mail(:to => user.email, :subject => "New Job is Assigned")
  end
end
