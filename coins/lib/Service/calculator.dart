class Calculator{

  static double UsdToEur(double USD, double EUR){
    double Euro = USD * EUR;
    return Euro;
  }

  static double UsdToJpy(double USD, double JPY){
    double Jpyy = USD * JPY;
    return Jpyy;
  }

  static double UsdToGBP(double USD, double GBP){
    double Gbpp = USD * GBP;
    return Gbpp;
  }

  static double RateCalculation(double coin, double totalCoins){

    double result = (coin + totalCoins) % 100;
    if(result <= 0){
      result = 0;
    }
    return result;
  }

}

