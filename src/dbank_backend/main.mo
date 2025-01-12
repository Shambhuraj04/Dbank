import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue : Float = 300;
  // currentValue := 300;

  stable var startTime = Time.now();
  // startTime := Time.now();
  // Debug.print(debug_show (startTime));

  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  public func debit(amount : Float) {
    var difference : Float = currentValue - amount;
    if (difference >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Amount larger than currentValue");
    };
  };
  public query func checkBalance() : async Float {
    Debug.print(debug_show (currentValue));
    return currentValue;

  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedSec = timeElapsedNS / 1000000000;

    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedSec));

    startTime := currentTime;
  };
};
