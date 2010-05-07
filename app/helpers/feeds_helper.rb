module FeedsHelper
  def feed_tag_list feed
    feed.tag_counts.sort {|t1,t2| t1.name <=> t2.name}.map {|tag| link_to tag, entries_path(:tagged => tag.name)}.join(", ")
  end
end
