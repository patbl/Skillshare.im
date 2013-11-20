require 'ffaker'

dalai_lama = User.create!(
  provider: "facebook",
  uid: "339188887615",
  facebook_url: "http://www.facebook.com/DalaiLama",
  name: "His Holiness the Dalai Lama",
  email: "patbl@live.com",
  location: "Tibet",
  about: "The 14th Dalai Lama (religious name: Tenzin Gyatso, shortened from Jetsun Jamphel Ngawang Lobsang Yeshe Tenzin Gyatso, born Lhamo Dondrub,[2] 6 July 1935) is the 14th and current Dalai Lama, as well as the longest lived incumbent. Dalai Lamas are the head monks of the Gelugpa lineage of Tibetan Buddhism. He won the Nobel Peace Prize in 1989, and is also well known for his lifelong advocacy for Tibetans inside and outside Tibet."
)

Proposal.create!(
  title: "forks and knives",
  description: "My spoons keep disappearing, so I bought a new flatware set. Now I don't know what to do with all my extra forks and knives!",
  location: "Tibet",
  category_list: "goods",
  user: dalai_lama,
  offer: true
)

psy = User.create!(
  provider: "facebook",
  uid: "165106760172502",
  facebook_url: "http://www.facebook.com/officialpsy",
  name: "Psy",
  email: "psy@hotmail.com",
  location: "Seoul, South Korea",
  about: <<-EOF
Park Jae-sang (born December 31, 1977), better known by his stage name Psy (Korean: 싸이, IPA: [s͈ai]; /ˈsaɪ/ SY), stylized PSY, is a South Korean singer, songwriter, rapper, dancer, record producer and television personality. Psy is known domestically for his humorous videos and stage performances, and internationally for his hit single "Gangnam Style." The song's refrain "Oppan Gangnam Style" (translated as "Big brother is Gangnam style", with Psy referring to himself)[1][2] was entered into The Yale Book of Quotations as one of the most famous quotes of 2012.[3]

On October 23, 2012, Psy met UN Secretary General Ban Ki-moon at the United Nations Headquarters where Ban expressed his desire to work with the singer because of his "unlimited global reach".[4] On December 21, 2012, his music video for "Gangnam Style" exceeded 1 billion views on YouTube, becoming the first and currently only video to do so in the website's history.[5][6] Psy was subsequently recognized by the media as the "King of YouTube".[7][8][9]

In December 2012, MTV noted Psy's rise from little-known outside of South Korea to "global superstar", and, for being first in the YouTube-era to secure a place in pop-culture history, hailed the singer as the "Viral Star of 2012".[10] On December 31, 2012, Psy performed in a globally televised New Year's Eve celebration with American rapper MC Hammer on-stage in front of a live audience of over a million people in Times Square, New York City.[11][12]
EOF
)

Proposal.create!(
  title: "funky dance moves",
  description: "Oppa Gangnam style!",
  location: "Seoul",
  category_list: "services",
  user: psy,
  offer: true
)

shakira = User.create!(
  provider: "facebook",
  uid: "5027904559",
  facebook_url: "http://www.facebook.com/shakira",
  name: "Shakira",
  email: "potus@whitehouse.gov",
  location: "Barranquilla, Colombia",
  about: <<EOF
Shakira Isabel Mebarak Ripoll (pronounced: [ʃaˈkiɾa isaˈβel meβa'ɾak riˈpol]; born February 2, 1977),[2] known professionally as Shakira (English /ʃəˈkɪərə/,[3] Spanish: [ʃaˈkiɾa]), is a Colombian singer-songwriter, dancer, record producer, choreographer and model. Born and raised in Barranquilla, she began performing in school, demonstrating Latin, Arabic, and rock and roll influences and belly dancing abilities. Shakira released her first studio albums, Magia and Peligro, in the early 1990s, failing to attain commercial success; however, she rose to prominence in Latin America with her major-label debut, Pies Descalzos (1996), and her fourth album, Dónde Están los Ladrones? (1998).

Shakira entered the English-language market with her fifth album, Laundry Service (2001), which has sold over 20 million copies worldwide.[4] Its lead single, "Whenever, Wherever", became the best-selling single of 2002. Her success was solidified with her sixth and seventh albums Fijación Oral, Vol. 1 and Oral Fixation, Vol. 2 (2005), the latter of which spawned the best-selling song of the 21st century[citation needed], "Hips Don't Lie". Shakira's eighth and ninth albums, She Wolf (2009) and Sale el Sol (2010), received critical praise but suffered from limited promotion due to her strained relationship with label Epic Records. Her official song for the 2010 FIFA World Cup, "Waka Waka (This Time for Africa)", became the biggest-selling World Cup song of all time. With over 550 million views, its music video is the eighth most-watched video on YouTube. Since 2013, Shakira has served as a coach on the American version of The Voice, although she temporarily left the series during the fifth season.

Shakira has won many awards including five MTV Video Music Awards, two Grammy Awards, eight Latin Grammy Awards, seven Billboard Music Awards, twenty-eight Billboard Latin Music Awards and has been Golden Globe-nominated. She has a star on the Hollywood Walk of Fame, and she is the highest-selling Colombian artist of all time, having sold a total of 125 million records worldwide, over 70 million albums and 55 million singles.[5][6][7][8][9][10] Her U.S. album sales stand at 9.9 million.[11] Outside of her work in the music industry, Shakira is also involved in philanthropic activities through charity work and benefit concerts, notably her Pies Descalzos Foundation, her performance at the "Clinton Global Initiative" created by former U.S. President Bill Clinton, and her invitation to the Oval Office by President Barack Obama in February 2010 to discuss early childhood development.[12]
EOF
)

Proposal.create!(
  title: "Rabiosa",
  description: Faker::Lorem.paragraphs(2).join("\n\n"),
  location: "Barcelona, Spain",
  category_list: "goods",
  user: shakira,
  offer: true
)

Proposal.create!(
  title: "Hips Don't Lie",
  description: %{"Hips Don't Lie" is a song by Colombian singer-songwriter Shakira featuring Haitian rapper Wyclef Jean for the reissue of Shakira's sixth studio album, Oral Fixation, Vol. 2. It was released on February 28, 2006, by Epic Records as the third single from the album. The song was written and produced by Shakira, Jean, and Jerry 'Wonder' Duplessis, and LaTravia Parker. "Hips Don't Lie" is a salsa and reggaeton song, which heavily incorporates samples from Jean's earlier single "Dance Like This" and "Amores Como el Nuestro" written by Omar Alfanno.

Upon its release, "Hips Don't Lie" received generally favorable reviews from music critics. It received several accolades, including a People's Choice Award, an MTV Latin America Video Music Award, and an MTV Video Music Award. "Hips Don't Lie" reached the number-one spot on charts in at least 55 countries[1] including the US Billboard Hot 100, becoming her first number-one single in the country. It also broke the record for the most radio plays in a single week in the United States. The song was eventually certified double-platinum by the Recording Industry Association of America (RIAA), where it has sold over five million copies. It additionally topped charts in nations including Australia, Italy, and the United Kingdom. Having sold over ten million copies by the turn of the decade, the track became the best-selling single of the 21st century[2] in physical singles and digital downloads combined. It is widely recognized as one of Shakira's signature songs.},
  location: "Barcelona, Spain",
  category_list: "goods",
  user: shakira,
  offer: true
)

Proposal.create!(
  title: "La tortura",
  description: Faker::Lorem.paragraphs(3).join("\n\n"),
  location: "Barcelona, Spain",
  category_list: "goods",
  user: shakira,
  offer: true
)

Proposal.create!(
  title: "Waka Waka",
  description: Faker::Lorem.paragraphs(4).join("\n\n"),
  location: "Barcelona, Spain",
  category_list: "goods",
  user: shakira,
  offer: true
)

Proposal.create!(
  title: "Loca",
  description: Faker::Lorem.paragraphs(5).join("\n\n"),
  location: "Barcelona, Spain",
  category_list: "goods",
  user: shakira,
  offer: true
)
