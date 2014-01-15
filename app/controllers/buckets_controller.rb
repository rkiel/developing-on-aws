class BucketsController < ApplicationController

  def index
    s3 = AWS::S3.new(region: "us-east-1")
    @buckets = s3.buckets
  end

  def new
    @bucket = Bucket.new
  end

  def create
    bucket = params[:bucket]
    name   = bucket[:name]
    logger.error "name is #{name}"
    s3 = AWS::S3.new(region: "us-east-1")
      bucket = s3.buckets.create(name)
      logger.error "bucket created"
    redirect_to action: :index
  end
end
