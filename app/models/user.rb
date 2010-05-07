class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  acts_as_tagger

  has_and_belongs_to_many :feeds

  def to_s
    email
  end

  def owned_tag_counts
    owned_taggings.all(
      :select => "count(*) count, taggings.tag_id, tags.name as name",
      :joins => :tag,
      :group => "taggings.tag_id, name").sort {|a,b| b.count<=>a.count}
  end
end
