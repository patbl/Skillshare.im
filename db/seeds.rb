sam = User.create!({
                     provider: "facebook",
                     uid: "abc",
                     name: "Sam Johnson",
                     email: "samjohnson@gmail.com",
                     location: "Lichfield, England",
                     about: "A man of letters.",
                   })
forks = Proposal.create!({
                           title: "forks and knives",
                           description: "My spoons keep disappearing, so I bought a new flatware set. Now I don't know what to do with all my extra forks and knives!",
                           location: "Lichfield, England",
                           category: "goods",
                           user: sam,
                           offer: true
                         })

george = User.create!({
                        provider: "facebook",
                        uid: "def",
                        name: "Jorge Shrub",
                        email: "george@hotmail.com",
                        location: "Midland, Texas"
                      })

rubs = Proposal.create!({
                          title: "back rubs",
                          description: "Relax with one of my world-famous back rubs!",
                          location: "Midland, Texas",
                          category: "services",
                          user: george,
                          offer: true
                        })

barack = User.create!({
                        provider: "facebook",
                        uid: "ghi",
                        name: "BO",
                        email: "potus@whitehouse.gov",
                        location: "Washington, D.C."
                      })

drones = Proposal.create!({
                            title: "drones",
                            description: "Be careful with the big red button, especially if you're using the drones stateside.",
                            location: "Washington, D.C.",
                            category: "goods",
                            user: barack,
                            offer: true
                          })
