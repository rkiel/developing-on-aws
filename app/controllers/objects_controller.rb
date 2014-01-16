class ObjectsController < ApplicationController

  before_action :lookup

  def index
    @objects = @bucket.objects
  end

private

  def lookup
    @s3 = AWS::S3.new(region: "us-east-1")
    @bucket = @s3.buckets[params[:bucket_id]]
  end
end
