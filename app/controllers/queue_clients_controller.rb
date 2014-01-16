class QueueClientsController < ApplicationController

  before_action :lookup

  def show
    queue = @sqs.queues.named(params[:id])
    queue.send_message("hello world #{Time.now}")
    flash[:notice] = "Sent message"
    redirect_to message_queues_path
  end

private

  def lookup
    @sqs = AWS::SQS.new
  end

end
