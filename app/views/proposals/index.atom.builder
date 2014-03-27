def describe_proposal(proposal)
  text = "#{proposal.class}: #{proposal.description}"
  markdown(text)
end

atom_feed do |feed|
  feed.title "Skillshare.im Offers and Wanteds"
  feed.updated @updated_at
  @proposals.each do |proposal|
    feed.entry proposal do |entry|
      entry.title proposal.title
      entry.content describe_proposal(proposal), type: :html
      entry.author do |author|
        author.name proposal.user.name
      end
    end
  end
end
