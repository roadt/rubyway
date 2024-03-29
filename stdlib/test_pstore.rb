


require 'pstore'

class WikiPage
  def initialize (page_name, author, contents)
    @page_name = page_name
    @revisions = Array.new
    add_revision(author, contents)
  end

  attr_reader :page_name
    
  def add_revision(author, contents)
    @revisions << { :created => Time.now,
      :author => author,
      :contents => contents }
  end

  def wiki_page_references
    [@page_name] + @revisions.last[:contents].scan(/\b(?:[A-Z]+[a-z]+){2,}/)
  end
end

home_page = WikiPage.new('HomePage', 'James Edward Gray II', 
                         'A page about the JoysOfDocumentation...')
wiki = PStore.new('wiki-pages.pstore')
wiki.ultra_safe = true
wiki.transaction do # begin transaction ; do all of this or none of it
  #store page ...
  wiki[home_page.page_name] = home_page
  # ensure that an index has been created...
  wiki[:wiki_index] ||= Array.new
  # update wiki index...
  wiki[:wiki_index].push(*home_page.wiki_page_references)
end  # commit changes to wiki data store file


# read wiki data
wiki.transaction(true) do # begin read-only transaction, no changes allowed
  wiki.roots.each do |data_root_name|
    p data_root_name
    p wiki[data_root_name]
  end
end


  
