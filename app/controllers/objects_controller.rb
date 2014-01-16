class ObjectsController < ApplicationController

  before_action :lookup

  def index
    FileUtils.chdir "/vagrant/app/assets/images" do
      Dir.glob("*.jpg").each do |name|
        @bucket.objects.create(name,File.read(name), :acl => :public_read)
      end
    end
    @objects = @bucket.objects
  end

  def destroy
    bucket = @s3.buckets[params[:bucket_id]]
    bucket.objects[params[:id]].delete
    redirect_to action: :index
  end
private

  def lookup
    @s3 = AWS::S3.new(region: "us-east-1")
    @bucket = @s3.buckets[params[:bucket_id]]
  end
end
