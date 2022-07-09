
class Rides {
  String _source;
  String _destination;
  String _date;
  String _id;
  String _name;
  String _photoUrl;
  String _mobileNumber;
  String _totalSeats;
  String _time;
  String _route;
  String _price;

  Rides(
      this._source,
      this._destination,
      this._date,
      this._id,
      this._name,
      this._photoUrl,
      this._mobileNumber,
      this._totalSeats,
      this._time,
      this._route,
      this._price);

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get route => _route;

  set route(String value) {
    _route = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get totalSeats => _totalSeats;

  set totalSeats(String value) {
    _totalSeats = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String get photoUrl => _photoUrl;

  set photoUrl(String value) {
    _photoUrl = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;
  }

  String get source => _source;

  set source(String value) {
    _source = value;
  }
}

class RidesCreated {
  String _source;
  String _destination;
  String _remainingSeats;
  String _id;
  String _timeStamp;

  RidesCreated(this._source, this._destination, this._remainingSeats, this._id,
      this._timeStamp);

  String get source => _source;

  set source(String value) {
    _source = value;
  }

  String get timeStamp => _timeStamp;

  set timeStamp(String value) {
    _timeStamp = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get remainingSeats => _remainingSeats;

  set remainingSeats(String value) {
    _remainingSeats = value;
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;
  }
}

class RidesHistory {
  String _source;
  String _destination;
  String _date;
  String _remainingSeats;

  RidesHistory(
      this._source, this._destination, this._date, this._remainingSeats);

  String get remainingSeats => _remainingSeats;

  set remainingSeats(String value) {
    _remainingSeats = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;
  }

  String get source => _source;

  set source(String value) {
    _source = value;
  }
}
class BookedHistory{
  String _source;
  String _destination;
  String _date;
  String _user;
  String _bookedseats;

  BookedHistory(this._source, this._destination, this._date, this._bookedseats, this._user);

  String get bookedseats => _bookedseats;

  set bookedseats(String value) {
    _bookedseats = value;
  }

  String get user => _user;

  set user(String value) {
    _user = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;
  }

  String get source => _source;

  set source(String value) {
    _source = value;
  }
}

class CreateRideDetails {
  String _startPoint;
  String _endPoint;
  String _route;
  String _price;
  String _time;
  String totalPassenger;

  CreateRideDetails(this._startPoint, this._endPoint, this._route, this._price,
      this._time, this.totalPassenger);

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get route => _route;

  set route(String value) {
    _route = value;
  }

  String get endPoint => _endPoint;

  set endPoint(String value) {
    _endPoint = value;
  }

  String get startPoint => _startPoint;

  set startPoint(String value) {
    _startPoint = value;
  }
}

class PassengerModel {
  String passengerID;
  String seatBooked;
  String name;
  String photoUrl;
  String mobileNumber;

  PassengerModel(
      this.passengerID, this.seatBooked, this.name, this.photoUrl, this.mobileNumber);
}