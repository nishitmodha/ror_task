task :good_morning_mail => :environment do
  Student.all.each do |student|
    StudentMailer.good_morning_mail(student).deliver_now
  end
end
