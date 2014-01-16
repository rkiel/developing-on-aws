class BucketsController < ApplicationController

  before_action :lookup

  def index
    @buckets = @s3.buckets
  end

  def new
    @bucket = Bucket.new
  end

  def create
    bucket = params[:bucket]
    name   = bucket[:name]
    logger.error "name is #{name}"
    if name.blank?
      flash[:error] = "Name is missing"
    else
      bucket = @s3.buckets[name]
      if bucket.exists?
        flash[:error] = "#{name} is already a bucket"
      else
        bucket = @s3.buckets.create(name)
      end
    end
    redirect_to action: :index
  end

  def destroy
    bucket = @s3.buckets[params[:id]]
    bucket.delete
    redirect_to action: :index
  end

private

  def lookup
    @s3 = AWS::S3.new(region: "us-east-1")
  end

end
