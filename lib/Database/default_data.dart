
import 'moor_database.dart';

class DataInfo{
  List<Oxide> oxides=[
    Oxide( name: "SiO2", role: "gf", defRole: "gf", mass: 60.09),
    Oxide( name: "Al2O3", role: "s", defRole: "s", mass: 101.96),
    Oxide( name: "Na2o", role: "a", defRole: "a", mass: 61.98),
    Oxide( name: "MgO", role: "ae", defRole: "ae", mass: 40.31),
    Oxide( name: "CaO", role: "ae", defRole: "ae", mass: 56.08),
  ];
  List<Mat> mats=[
    Mat(name: "Nepheline Syenite", info: "Nepheline Syenite from the East Coast ", def: true)
  ];
  List<MatOxide> matOxides=[
    MatOxide( oxideId: 1, matId: 1, count: 98.24),
    MatOxide(oxideId: 2, matId: 1, count: 0.02),
    MatOxide( oxideId: 3, matId: 1, count: 1.7),
    MatOxide( oxideId: 4, matId: 1, count: 1.7),
    MatOxide( oxideId: 5, matId: 1, count: 1.7),
  ];
}