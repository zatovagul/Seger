
import 'moor_database.dart';
//₂₃₄₅
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
    Oxide( name: "MnO3", role: "o", defRole: "o", mass: 86.94),
    Oxide( name: "FeO", role: "o", defRole: "o", mass: 71.84),
    Oxide( name: "Fe2O3", role: "o", defRole: "o", mass: 159.69),
    Oxide( name: "CoO", role: "o", defRole: "o", mass: 74.93),
    Oxide( name: "NiO", role: "o", defRole: "o", mass: 74.6928),
    Oxide( name: "CuO", role: "o", defRole: "o", mass: 79.545),
    Oxide( name: "Cu2O", role: "o", defRole: "o", mass: 143.09),

    Oxide( name: "CdO", role: "o", defRole: "o", mass: 128.41),
    Oxide( name: "ZnO", role: "ae", defRole: "ae", mass: 81.39),
    Oxide( name: "F", role: "o", defRole: "o", mass: 18.9984),
    Oxide( name: "PbO", role: "ae", defRole: "ae", mass: 223.2),
    Oxide( name: "SnO2", role: "o", defRole: "o", mass: 150.7),
    Oxide( name: "HfO2", role: "o", defRole: "o", mass: 210.49),
    Oxide( name: "Nb2O5", role: "o", defRole: "o", mass: 265.81),
    Oxide( name: "Ta2O5", role: "o", defRole: "o", mass: 441.893),
    Oxide( name: "MoO3", role: "o", defRole: "o", mass: 143.94),
    Oxide( name: "WO3", role: "o", defRole: "o", mass: 231.84),
    Oxide( name: "OsO2", role: "o", defRole: "o", mass: 222.229),
    Oxide( name: "IrO2", role: "o", defRole: "o", mass: 224.22),
    Oxide( name: "PtO2", role: "o", defRole: "o", mass: 227.08),
    Oxide( name: "Ag2O", role: "o", defRole: "o", mass: 231.735),
    Oxide( name: "Au2O3", role: "o", defRole: "o", mass: 441.931),
    Oxide( name: "GeO2", role: "gf", defRole: "gf", mass: 104.61),
    Oxide( name: "As2O3", role: "o", defRole: "o", mass: 197.841),
    Oxide( name: "Sb2O3", role: "o", defRole: "o", mass: 291.52),
    Oxide( name: "Bi2O3", role: "o", defRole: "o", mass: 465.96),
    Oxide( name: "SeO2", role: "o", defRole: "o", mass: 110.96),
    Oxide( name: "La2O3", role: "o", defRole: "o", mass: 325.81),
    Oxide( name: "CeO2", role: "o", defRole: "o", mass: 172.115),
    Oxide( name: "PrO2", role: "o", defRole: "o", mass: 172.906),
    Oxide( name: "Pr2O3", role: "o", defRole: "o", mass: 329.813),
    Oxide( name: "Nd2O3", role: "o", defRole: "o", mass: 336.48),
    Oxide( name: "U3O8", role: "o", defRole: "o", mass: 842.1),
    Oxide( name: "Sm2O3", role: "o", defRole: "o", mass: 348.72),
    Oxide( name: "Eu2O3", role: "o", defRole: "o", mass: 351.926),
    Oxide( name: "Tb2O3", role: "o", defRole: "o", mass: 365.85),
    Oxide( name: "Dy2O3", role: "o", defRole: "o", mass: 372.998),
    Oxide( name: "Ho2O3", role: "o", defRole: "o", mass: 377.859),
    Oxide( name: "Er2O3", role: "o", defRole: "o", mass: 382.56),
    Oxide( name: "Tm2O3", role: "o", defRole: "o", mass: 385.866),
    Oxide( name: "Yb2O3", role: "o", defRole: "o", mass: 394.08),
    Oxide( name: "Lu2O3", role: "o", defRole: "o", mass: 397.932),
  ];
  List<Mat> mats=[
    Mat(name: "Nepheline Syenite", lowerName: "nepheline syenite", info: "Nepheline Syenite from the East Coast ", def: true)
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
  Recipe recipe= Recipe(id:1, name: "", date: null, folderId: null, image: null);
}