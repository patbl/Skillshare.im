atom_feed do |feed|
  feed.title "Skillshare.im Offers"
  feed.updated @offers.maximum(:updated_at)
  @offers.each do |offer|
    feed.entry offer do |entry|
      entry.title offer.title
      entry.content offer.description
      entry.author do |author|
        author.name offer.user.name
      end
    end
  end
end