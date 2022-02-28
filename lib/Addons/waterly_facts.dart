//? Courtesy of: "https://savethewater.org/water-facts/"

import 'dart:math';

List<String> wateryFacts = [
  'Adult humans are 60 percent water, and our blood is 90 percent water',
  'There is no universally agreed quantity of water that must be consumed daily',
  'Water is essential for proper functioning of the kidneys and other bodily functions',
  'When dehydrated, the skin can become more vulnerable to skin disorders and wrinkling',
  'Drinking water instead of soda can help with weight loss',
  'Water lubricates your joints',
  'Water forms saliva and mucus',
  'Water delivers oxygen throughout the body.',
  'Water boosts skin health and beauty',
  'Water cushions the brain, spinal cord, and other sensitive tissues',
  'Water regulates body temperature',
  'Water flushes out body waste',
  'Water helps regulate blood pressure',
  'Water makes minerals and nutrients accessible',
  'Water prevents kidney damage',
  'Water boosts performance during exercise.',
  'Water reduces the chance of a hangover.',
  "There are 1.6 million deaths per year attributed to dirty water and poor sanitation",
  "One-third of the world population lives in water stressed countries now",
  "The average distance that women in developing countries walk to collect water per day is four miles and the average weight that women carry on their heads is approximately 44 pounds",
  "90 percent of the Europe alpine glaciers are in retreat",
  "Each day almost 10,000 children under the age of 5 in Third World countries die as a result of illnesses contracted by use of impure water",
  "Most of the 3rd world's people must walk at least 3 hours to fetch water",
  "Of the 1200 species listed as threatened or endangered, 50% depend on rivers and streams",
  "At birth, water accounts for approximately 80 percent of an infant's body weight",
  "Drinking 5 glasses of water daily decreases the risk of colon cancer by 45%, plus it can slash the risk of breast cancer by 79% and one is 50% less likely to develop bladder cancer",
  "On average it takes about 2 cups of water to make up for the dehydration caused by a single alcoholic drink or a cup of coffee",
  "It takes about 1 gallon of water to process a quarter pound of hamburger",
  "Lack of water, is the number one trigger of daytime fatigue",
  "Showering, bathing and using the toilet account for about two-thirds of the average family's water usage",
];

//! Generate Random Fact.
var random = Random();
var randomFact = wateryFacts[random.nextInt(wateryFacts.length)];
