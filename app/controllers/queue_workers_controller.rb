class QueueWorkersController < ApplicationController

  before_action :lookup

  def show
    queue = @sqs.queues.named(params[:id])

    queue.receive_message do |message|
      flash[:notice] = "#{queue.arn} - #{message.id} - #{message.body}"
    end
    redirect_to message_queues_path
  end

private

  def lookup
    @sqs = AWS::SQS.new
  end

end

