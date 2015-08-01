ResultWeight.delete_all
# from https://chitika.com/google-positioning-value
ResultWeight.create!([
  { position: 1,  weight: 32.5 },
  { position: 2,  weight: 17.6 },
  { position: 3,  weight: 11.4 },
  { position: 4,  weight: 8.1 },
  { position: 5,  weight: 6.1 },
  { position: 6,  weight: 4.4 },
  { position: 7,  weight: 3.5 },
  { position: 8,  weight: 3.1 },
  { position: 9,  weight: 2.6 },
  { position: 10, weight: 2.4 },
  { position: ResultWeight::UNKNOWN, weight: 1 }
])
