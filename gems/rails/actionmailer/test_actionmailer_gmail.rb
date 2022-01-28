# coding: utf-8


#
#  Simple action mailer examples
#

require 'bundler'
Bundler.setup

require 'action_mailer'

FROM = ENV['test.gmail.username']
FROM_PASS = ENV['test.gmail.password']
TO = ENV["test.gmail.username"]

ActionMailer::Base.smtp_settings  = {
 :address=>"smtp.gmail.com",
 :port=>587,
 :domain=>"xxx",
 :authentication=>"plain",
 :enable_starttls_auto=>true,
 :user_name=>FROM,
 :password=>FROM_PASS
}
  


class Notifier < ActionMailer::Base

  def welcome(recipient, sender)
    @recipient = recipient
    mail(:to => recipient,:from =>(sender or FROM),
         :subject => "[Signed up] Welcome #{recipient}")
  end

  def bcc(to, bcc, sender)
    mail(:to => to, bcc:  bcc.split(';'), from: sender, :subject => 'bcc test')  do |format|
      format.html  { render :inline => "<h1>bcc content我们</h1>"}
    end
  end

end


msg =  Notifier.welcome(TO, '你好')
msg.deliver_now

msg =  Notifier.bcc(nil, 'roadtang@gmail.com', '小路 athenam<testtest1999@gmail.com>')
msg.deliver_now

