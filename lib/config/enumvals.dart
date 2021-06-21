enum FieldType {
  name,
  email,
  password,
  phone,
  farmName,
  numberOfLayers,
  numberOfBroilers,
  address,
  state,
  lga,
  yearEstablished,
  eggsCollected,
  badEggs,
  batchName,
  batchQuantity,
  customerName,
  customerAddress,
  customerContact,
  crateOfEggPrice,
  chickenPrice,
  deadBirds,
  comment,
}

enum UserType {
  farmer,
  distributor,
}

enum OrderStatus {
  open,
  closed,
}

// Report card type
enum StockReport {
  chickens,
  eggs,
  fertilizer,
}

enum BirdType {
  broiler,
  layer,
}
