module MessageQueuesHelper

  def queue_name ( arn )
    arn.split(":").last
  end

end
