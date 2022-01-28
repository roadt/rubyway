

#
#  Simple action mailer examples
#

gem 'actionmailer', '3.2.13'

require 'action_mailer'

FROM = "from@from.com"
FROM_PASS = "xxx"
TO = "to@to.com"


ActionMailer::Base.smtp_settings  = {:address=>"smtp.gmail.com",
 :port=>587,
 :domain=>"gmail.com",
 :authentication=>"plain",
 :enable_starttls_auto=>true,
 :user_name=>FROM,
 :password=>FROM_PASS
}
  


class Notifier < ActionMailer::Base

  def welcome(recipient)
    @recipient = recipient
    mail(:to => recipient,:sender =>FROM,
         :subject => "[Signed up] Welcome #{recipient}",
         :body => "XXX")
  end
end


puts Notifier.welcome(TO).deliver
