atom_feed do |feed|
  feed.title "Skillshare.im Proposals"
  feed.updated @updated_at
  @proposals.each do |proposal|
    feed.entry proposal do |entry|
      entry.title proposal.title
      entry.content markdown(proposal.description), type: :html
      entry.author do |author|
        author.name proposal.user.name
      end
    end
  end
end
