class Fight
  include Sidekiq::Worker

  def perform(name1, name2, time)
    msg = "#{name1} He is in a battle with #{name2}\n"
    sleep(time)
    msg = "The battle Finish! #{name1} and #{name2} are tired."
  end
end
