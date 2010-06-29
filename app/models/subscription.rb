class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  acts_as_configurable do |c|
    c.string :view_mode
  end

  def self.available_options
    [ ["Full text", :full_text],
      ["Display only headers", :headers_only],
      ["Display only pictures", :pictures_only],
      ["Remove any media and formatting", :plain_text_only] ]
  end
end
