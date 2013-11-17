sam = User.create!(
  provider: "facebook",
  uid: "abc",
  name: "Sam Johnson",
  email: "patbl@live.com",
  location: "Lichfield, England",
  about: "A man of letters."
)

Proposal.create!(
  title: "forks and knives",
  description: "My spoons keep disappearing, so I bought a new flatware set. Now I don't know what to do with all my extra forks and knives!",
  location: "Lichfield, England",
  category_list: "goods",
  user: sam,
  offer: true
)

george = User.create!(
  provider: "facebook",
  uid: "def",
  name: "Jorge Shrub",
  email: "george@hotmail.com",
  location: "Midland, Texas",
  about: "I actually prefer clearing brush to running the world."
)

Proposal.create!(
  title: "back rubs",
  description: "Relax with one of my world-famous back rubs!",
  location: "Midland, Texas",
  category_list: "services",
  user: george,
  offer: true
)

barack = User.create!(
  provider: "facebook",
  uid: "ghi",
  name: "BO",
  email: "potus@whitehouse.gov",
  location: "Washington, D.C.",
  about: "Hello, everybody!"
)

Proposal.create!(
  title: "drones",
  description: "Be careful with the big red button, especially if you're using the drones stateside.",
  location: "Washington, D.C.",
  category_list: "goods",
  user: barack,
  offer: true
)

Proposal.create!(
  title: "The White House",
  description: "Be careful with the big red button, especially if you're using the drones stateside.",
  location: "Washington, D.C.",
  category_list: "goods",
  user: barack,
  offer: true
)

Proposal.create!(
  title: "Jet Blue",
  description: "Be careful with the big red button, especially if you're using the drones stateside.",
  location: "Washington, D.C.",
  category_list: "goods",
  user: barack,
  offer: true
)

Proposal.create!(
  title: "Basketball Skills",
  description: "Be careful with the big red button, especially if you're using the drones stateside.",
  location: "Washington, D.C.",
  category_list: "goods",
  user: barack,
  offer: true
)

Proposal.create!(
  title: "More Stuff",
  description: "Be careful with the big red button, especially if you're using the drones stateside.",
  location: "Washington, D.C.",
  category_list: "goods",
  user: barack,
  offer: true
)

