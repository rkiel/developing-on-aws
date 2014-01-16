class MessageQueuesController < ApplicationController

  before_action :lookup

  def index
    @queues = @sqs.queues
  end

  def new
    @queue = MessageQueue.new
  end

  def create
    message_queue = params[:message_queue]
    name  = message_queue[:name]
    if name.blank?
      flash[:error] = "Name is missing"
    else
      queue = @sqs.queues.create(name)
    end
    redirect_to action: :index
  end

  def destroy
    queue = @sqs.queues.named(params[:id])
    queue.delete
    redirect_to action: :index
  end

private

  def lookup
    @sqs = AWS::SQS.new
  end

end
