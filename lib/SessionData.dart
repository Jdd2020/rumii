class SessionData {
  String username = "";
  String housekey = "";

  SessionData();
  SessionData.data(String user, String house)
      : username = user,
        housekey = house;
}
