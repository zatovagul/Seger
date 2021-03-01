
import 'moor_database.dart';

class DataInfo{
  List<Oxide> oxides=[
    Oxide( name: "SiO2", role: "gf", defRole: "gf", mass: 60.09),
    Oxide( name: "Al2O3", role: "s", defRole: "s", mass: 101.96),
    Oxide( name: "B2O3", role: "s", defRole: "s", mass: 69.62),
    Oxide( name: "Li2O", role: "a", defRole: "a", mass: 29.88),
    Oxide( name: "Na2O", role: "a", defRole: "a", mass: 61.98),
    Oxide( name: "K2O", role: "a", defRole: "a", mass: 94.2),
    Oxide( name: "BeO", role: "ae", defRole: "ae", mass: 25.012),
    Oxide( name: "MgO", role: "ae", defRole: "ae", mass: 40.31),
    Oxide( name: "CaO", role: "ae", defRole: "ae", mass: 56.08),
    Oxide( name: "SrO", role: "ae", defRole: "ae", mass: 103.62),
    Oxide( name: "BaO", role: "ae", defRole: "ae", mass: 153.7),
    Oxide( name: "P2O5", role: "a", defRole: "a", mass: 141.94),
    Oxide( name: "TiO2", role: "o", defRole: "o", mass: 79.866),
    Oxide( name: "ZrO", role: "o", defRole: "o", mass: 107.22),
    Oxide( name: "ZrO2", role: "o", defRole: "o", mass: 214.44),
    Oxide( name: "V2O5", role: "o", defRole: "o", mass: 181.88),
    Oxide( name: "Cr2O3", role: "o", defRole: "o", mass: 151.99),
    Oxide( name: "MnO", role: "o", defRole: "o", mass: 70.9374),
    Oxide( name: "MnO2", role: "o", defRole: "o", mass: 86.94),
    Oxide( name: "FeO", role: "o", defRole: "o", mass: 71.84),
    Oxide( name: "Fe2O3", role: "o", defRole: "o", mass: 159.69),
    Oxide( name: "CoO", role: "o", defRole: "o", mass: 74.93),
    Oxide( name: "NiO", role: "o", defRole: "o", mass: 74.6928),
    Oxide( name: "CuO", role: "o", defRole: "o", mass: 79.545),
    Oxide( name: "Cu2O", role: "o", defRole: "o", mass: 143.09),
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
  List<Folder> folders=[
    Folder( name: "Favourites", del: false),
    Folder( name: "Testing", del: false),
    Folder( name: "Drafts", del: false),
  ];
}