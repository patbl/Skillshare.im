User.delete_all

dalai_lama = User.create(
  facebook_url: "http://www.facebook.com/DalaiLama",
  first_name: "His Holiness",
  last_name: "the Dalai Lama",
  email: "patbl@outlook.com",
  avatar_url: "http://graph.facebook.com/339188887615/picture",
  location: "Tibet",
  about: "The 14th Dalai Lama (religious name: Tenzin Gyatso, shortened from Jetsun Jamphel Ngawang Lobsang Yeshe Tenzin Gyatso, born Lhamo Dondrub,[2] 6 July 1935) is the 14th and current Dalai Lama, as well as the longest lived incumbent. Dalai Lamas are the head monks of the Gelugpa lineage of Tibetan Buddhism. He won the Nobel Peace Prize in 1989, and is also well known for his lifelong advocacy for Tibetans inside and outside Tibet."
)

Identity.create(
  provider: "facebook",
  uid: "339188887615",
  user: dalai_lama
)

100.times do |i|
  Offer.create(
    title: "#{i} forks and knives",
    description: "My spoons keep disappearing, so I bought a new flatware set. Now I don't know what to do with all my extra forks and knives!",
    category_list: "self-improvement",
    user: dalai_lama,
  )
end

100.times do |i|
  shakira = User.create(
    facebook_url: "http://www.facebook.com/shakira",
    first_name: "Shakira",
    last_name: "Isabel Mebarak Ripoll",
    email: "shakira#{i}@gmail.com",
    avatar_url: "http://graph.facebook.com/5027904559/picture",
    location: "Barranquilla, Colombia",
    about: %{Shakira Isabel Mebarak Ripoll (pronounced: [ʃaˈkiɾa isaˈβel meβa'ɾak riˈpol]; born February 2, 1977),[2] known professionally as Shakira (English /ʃəˈkɪərə/,[3] Spanish: [ʃaˈkiɾa]), is a Colombian singer-songwriter, dancer, record producer, choreographer and model. Born and raised in Barranquilla, she began performing in school, demonstrating Latin, Arabic, and rock and roll influences and belly dancing abilities. Shakira released her first studio albums, Magia and Peligro, in the early 1990s, failing to attain commercial success; however, she rose to prominence in Latin America with her major-label debut, Pies Descalzos (1996), and her fourth album, Dónde Están los Ladrones? (1998).

Shakira has won many awards including five MTV Video Music Awards, two Grammy Awards, eight Latin Grammy Awards, seven Billboard Music Awards, twenty-eight Billboard Latin Music Awards and has been Golden Globe-nominated. She has a star on the Hollywood Walk of Fame, and she is the highest-selling Colombian artist of all time, having sold a total of 125 million records worldwide, over 70 million albums and 55 million singles.[5][6][7][8][9][10] Her U.S. album sales stand at 9.9 million.[11] Outside of her work in the music industry, Shakira is also involved in philanthropic activities through charity work and benefit concerts, notably her Pies Descalzos Foundation, her performance at the "Clinton Global Initiative" created by former U.S. President Bill Clinton, and her invitation to the Oval Office by President Barack Obama in February 2010 to discuss early childhood development.[12]}
  )

  Identity.create(
    provider: "facebook",
    uid: "5027904559#{i}",
    user: shakira
  )
end

shakira = User.last

100.times do |n|
  Wanted.create(
    title: "#{n} new songs",
    description: "&c., &c.",
    category_list: "writing",
    user: shakira,
  )
end

Offer.create(
  title: "Hips Don't Lie",
  description: %{"Hips Don't Lie" is a song by Colombian singer-songwriter Shakira featuring Haitian rapper Wyclef Jean for the reissue of Shakira's sixth studio album, Oral Fixation, Vol. 2. It was released on February 28, 2006, by Epic Records as the third single from the album. The song was written and produced by Shakira, Jean, and Jerry 'Wonder' Duplessis, and LaTravia Parker. "Hips Don't Lie" is a salsa and reggaeton song, which heavily incorporates samples from Jean's earlier single "Dance Like This" and "Amores Como el Nuestro" written by Omar Alfanno.

Upon its release, "Hips Don't Lie" received generally favorable reviews from music critics. It received several accolades, including a People's Choice Award, an MTV Latin America Video Music Award, and an MTV Video Music Award. "Hips Don't Lie" reached the number-one spot on charts in at least 55 countries[1] including the US Billboard Hot 100, becoming her first number-one single in the country. It also broke the record for the most radio plays in a single week in the United States. The song was eventually certified double-platinum by the Recording Industry Association of America (RIAA), where it has sold over five million copies. It additionally topped charts in nations including Australia, Italy, and the United Kingdom. Having sold over ten million copies by the turn of the decade, the track became the best-selling single of the 21st century[2] in physical singles and digital downloads combined. It is widely recognized as one of Shakira's signature songs.},
  category_list: "self-improvement",
  user: shakira,
)

Offer.create(
  title: "Waka Waka",
  description: %{ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris neque magna, consequat sed justo vel, mattis aliquam ipsum. Etiam iaculis magna urna, ac vulputate arcu tincidunt sed. Nam ac tellus ac justo dapibus consectetur. Aenean eu sapien lacus. Nulla mattis vulputate dui, feugiat pharetra augue egestas at. Suspendisse enim nunc, lobortis a consequat in, auctor sit amet odio. Nunc tincidunt odio sed leo suscipit rhoncus. Duis tortor turpis, vehicula vitae viverra ut, sollicitudin nec orci. In sodales tempus nibh nec eleifend. Proin malesuada egestas ornare. Nam convallis arcu eget ipsum mollis venenatis. Morbi iaculis a ante vitae consequat. Vivamus egestas justo et scelerisque eleifend. Donec ultricies quis nibh ut viverra.

Donec malesuada dui ornare neque adipiscing sagittis. Proin tincidunt vestibulum mi, nec faucibus dolor bibendum sit amet. Duis imperdiet ligula quis viverra mattis. Phasellus nibh ante, pharetra in commodo sed, dignissim sit amet risus. Nam lacinia ipsum lectus, at ornare metus euismod ut. Maecenas vel nisl et lectus interdum mattis. Etiam sagittis ac ipsum ut molestie. Cras hendrerit sagittis fringilla. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam et nisl vel nunc scelerisque congue id et risus. Nunc blandit neque vel tortor pulvinar, in varius augue tempor. Morbi vel porttitor velit. Quisque quis sapien malesuada, ornare felis non, egestas erat. Sed volutpat id orci quis dictum. Cras nec dolor sed metus ornare tincidunt vitae sit amet mauris.},
  category_list: "self-improvement",
  user: shakira,
)

gravatar_user = User.create(
  first_name: "Gravatar",
  last_name: "User",
  email: "patbl@live.com",
  location: "Somewhere, World",
  about: "Just an ordinary, average guy."
)

Offer.create(
  title: "Skillz",
  description: "Something useful.",
  category_list: "writing",
  user: gravatar_user
)

no_gravatar_user = User.create(
  first_name: "No-Gravatar",
  last_name: "User",
  email: "doesnotexist@hotmail.com",
  location: "Somewhere, World",
  about: "I haven't had the time to upload a picture to Gravatar, or I don't know how to, or it seems like too much trouble."
)

Offer.create(
  title: "Skillz",
  description: "Something else useful.",
  category_list: "writing",
  user: no_gravatar_user
)
