/// Author: Karl
/// Date: 2021/11/29 上午9:58

///汽车抽象类
abstract class Car {
  int wheel = 4; //默认四个轮组
  int horsepower; //马力

  ///设置马力
  void setHorsepower(int power) {
    horsepower = power;
  }

  ///驾驶
  void drive() {
    print('你可以把车开起来跑');
  }

  ///输出马力
  void showHorsepower();

  ///门
  void door();
}

class Oil {
  void refuel() {
    print('去加油站加油了');
  }

  void maintain() {
    print('我需要更换机油三滤冷却液、检查轮胎蓄电池');
  }

}

mixin Electricity {
  void charge() {
    print('去充电桩充电了');
  }

  void maintain() {
    print('我需要检查轮胎电池');
  }
}


class SportCar extends Car {
  final int defaultPower = 200;
  @override
  int wheel = 8;

  @override
  void door() {
    print('我是两门双座大后超有${wheel}个轮子');
    print('我是两门双座大后超有${super.wheel}个轮子');
  }

  @override
  void showHorsepower() {
    if (horsepower == null) {
      setHorsepower(defaultPower);
    }
    print('我$horsepower匹马力');
  }

  @override
  void setHorsepower(int power) {
    power = turbo(power);
    super.setHorsepower(power);
  }

  int turbo(int power) {
    ///涡轮提升20%马力
    return power ~/ 5 + power;
  }
}

class Cannon {
  void fire() {
    print('开火！');
  }
}

abstract class Gun {
  void gun();
}

class Tank implements Car, Cannon, Gun {
  @override
  int horsepower;

  @override
  int wheel = 5;

  @override
  void door() {
    print('我有$wheel五对负重轮');
  }

  @override
  void drive() {
    print('59下山了');
  }

  @override
  void setHorsepower(int power) {
    horsepower = power;
  }

  @override
  void showHorsepower() {
    print('我柴油机$horsepower匹马力');
  }

  @override
  void fire() {
    print('开火！');
  }

  @override
  void gun() {
    print('This is machine gun!! OK，hahah');
  }
}

class SedanOil extends Car with Oil,OilTank{
  @override
  void door() {
    print('我是四门双座大后超');
  }

  @override
  void showHorsepower() {
    print('我$horsepower匹马力');
  }

  @override
  void remove() {
    volume -=volumeSpare;
    print('去掉了$volumeSpare升的副油箱');
    volumeSpare = 0;
  }
}

abstract class OilTank{
  int volume = 68;
  int volumeSpare = 0;

  ///增加备用油箱
  void spare(int b){
    volumeSpare = b;
    volume+=b;
    print('增加了$volumeSpare升的副油箱');
  }

  ///去掉备用油箱
  void remove();
}

abstract class Battery  {
    ///电量
    int electricity;

    ///补充电池冷却液
    void replenishCoolant();
}


abstract class ElectricityCar extends Car with Electricity implements Battery {
  @override
  void replenishCoolant() {
    print('加入冷却液');
  }
}

mixin BladeBattery on ElectricityCar{
  void safe(){
    print('刀片电池我更加安全了');
  }
}


class SedanElectricity extends ElectricityCar with BladeBattery{
  @override
  void door() {
    print('我是五门五座瓦罐');
  }

  @override
  void showHorsepower() {
    print('我轮上马力$horsepower匹');
  }

  @override
  int electricity;
}

class SedanDmi extends Car with Oil, Electricity {
  bool hasOil = false;

  @override
  void door() {
    print('我是四门五座车');
  }

  @override
  void showHorsepower() {
    print('我有$horsepower匹马力');
  }

  @override
  void maintain() {
    super.maintain();
  }

  @override
  void charge() {
    if (hasOil) {
      print('发动机给电池充电');
      hasOil = false;
    } else {
      print('去充电桩充电了或者去加油');
      hasOil = true;
    }
  }
}
