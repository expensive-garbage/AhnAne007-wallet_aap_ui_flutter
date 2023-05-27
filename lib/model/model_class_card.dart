

class CardModelClass {
  int? _expiryMonth;
  int? _expiryYear;
  int? _balance;
  int? _accountNumber;
  final color;

  CardModelClass(
      this._expiryMonth,
      this._expiryYear,
      this._balance,
      this._accountNumber,
      this.color);

  int? getAccountNumber() {
    return _accountNumber;
  }

  void setAccountNumber(int value) {
    _accountNumber = value;
  }

  int? getBalance() {
    return _balance;
  }

  void setBalance(int value) {
    _balance = value;
  }

  int? getExpiryYear() {
    return _expiryYear;
  }

  void setExpiryYear(int value) {
    _expiryYear = value;
  }

  int? getExpiryMonth() {
    return _expiryMonth;
  }

  void setExpiryMonth(int value) {
    _expiryMonth = value;
  }
}
