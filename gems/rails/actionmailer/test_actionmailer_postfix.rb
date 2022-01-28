

#
#  Simple action mailer examples
#

gem 'actionmailer', '3.2.13'

require 'action_mailer'

FROM = "from@from.com"
FROM_PASS = "xxx"
TO = "roadt@oldman"


ActionMailer::Base.smtp_settings  = {:address=>"localhost",
 :port=>25,
 :domain=>"oldman.oldman",
# :authentication=>"plain",
 :enable_starttls_auto=>true,
# :user_name=>FROM,
# :password=>FROM_PASS
}



ActionMailer::Base.smtp_settings  = {:address=>"localhost",
 :port=>1025,
 :domain=>"localhost",
# :authentication=>"plain",
 :enable_starttls_auto=>true,
# :user_name=>FROM,
# :password=>FROM_PASS
}
  


class Notifier < ActionMailer::Base

  helper do
    def emission(s)
      if s.length > 10
        s[0..9] + "..."
      else
        s
      end
    end
  end

  def welcome(recipient, cc, bcc)
    @recipient = recipient
    mail(:to => recipient,:sender =>FROM,
         :cc => cc, 
         :bcc => bcc,
         :subject => "[Signed up] Welcome #{recipient}",
         :body => "XXX")
  end
end


puts Notifier.welcome(nil, [''], ['']).deliver

puts Notifier.welcome(nil, ['a@a.com'], ['']).deliver
