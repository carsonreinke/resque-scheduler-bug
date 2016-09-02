
class TestJob < ActiveJob::Base
  queue_as :basic

  def perform(thing_to_say)
    puts thing_to_say
  end

end