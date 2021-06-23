class Birds {
  String birdType;
  String batchName;
  int quantity;
  int deadBirds;
  int aliveBirds;
  String startDate;
  String month;
  String day;
  String year;
  String comment;
  int batchCount;
  int bacthesCounted;

  Birds({
    this.batchName = "",
    this.birdType = "Broiler",
    this.quantity = 0,
    this.startDate = "",
    this.month = "January",
    this.day = "1",
    this.year = "2021",
    this.batchCount = 0,
    this.bacthesCounted = 0,
    this.deadBirds = 0,
    this.comment = "",
    this.aliveBirds,
  });
}
