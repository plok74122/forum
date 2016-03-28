namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    User.delete_all

    5.times do
      User.create(:email => Faker::Internet.email,
                          :password => 'qwer4321',
                          :confirmed_at => Faker::Time.between(DateTime.now - 15, DateTime.now)
      )
    end

    Article.delete_all
    Comment.delete_all
    50.times do
      article = Article.create(:title => Faker::Book.title,
                               :content => Faker::Lorem.paragraph,
                               :user => User.all.sample,
                               :article_type => ArticleType.all.sample
      )

      (3+rand(0..5)).times do
        article.comments.create!(:comment => Faker::Lorem.sentence,
                                :user => User.all.sample

        )
      end
    end

  end
end
