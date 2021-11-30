import 'package:sort_algorithm/src/calssExtend/car.dart';

/// Author: Karl
/// Date: 2021/11/29 上午10:52
/// Description:

void main() {
  /*var mx5 = SportCar();
  mx5.showHorsepower();
  mx5.wheel = 8;
  mx5.door();
  mx5.drive();
  var tank = Tank();
  tank.setHorsepower(1600);
  tank.showHorsepower();
  tank.door();
  tank.drive();
  tank.fire();
  tank.gun();

  print('--------油车：');
  var sedanOil = SedanOil()..horsepower =200;
  sedanOil.showHorsepower();
  sedanOil.maintain();
  sedanOil.refuel();
  sedanOil.spare(30);
  sedanOil.remove();

  print('--------电车：');
  var sedanElectricity = SedanElectricity()..horsepower = 300;
  sedanElectricity.showHorsepower();
  sedanElectricity.maintain();
  sedanElectricity.charge();
  sedanElectricity.replenishCoolant();
  sedanElectricity.safe();*/
  var dmi = SedanDmi()..horsepower = 300;
  dmi.showHorsepower();
  dmi.maintain();
  dmi.charge();
}
