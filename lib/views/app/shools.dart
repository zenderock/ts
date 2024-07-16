import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_vision/services/shools_service.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/utils/constants/sizes.dart';
import 'package:the_vision/views/app/detail_folder.dart';

class ShoolsScreen extends StatefulWidget {
  const ShoolsScreen({super.key});

  @override
  _ShoolsScreenState createState() => _ShoolsScreenState();
}

class _ShoolsScreenState extends State<ShoolsScreen> {
  late Future<List<School>> futureSchools;

  String valueString(value) {
    if (value.toString().isEmpty || value == null) {
      return "---";
    } else {
      return value.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    futureSchools = SchoolsService().getSchools();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nos écoles"),
        elevation: 1,
        backgroundColor: Colors.blue.shade100,
      ),
      body: FutureBuilder<List<School>>(
        future: futureSchools,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(TVSizes.md)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.network(
                                              height: 60,
                                              width: 60,
                                              snapshot.data![index].logo ??
                                                  'https://placehold.co/80x40/png',
                                            ),
                                            Image.network(
                                              height: 50,
                                              width: 50,
                                              snapshot.data![index].flagUrl ??
                                                  'https://placehold.co/60x40/png',
                                            ),
                                          ]),
                                      const SizedBox(
                                          height: TVSizes.spaceBetweenSections),
                                      Text(
                                        snapshot.data![index].nom,
                                        style: const TextStyle(
                                            fontSize: TVSizes.fontLg,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      LineInfo(
                                          label: "Offre de bourse",
                                          value: valueString(snapshot
                                              .data![index].offreBourse)),
                                      LineInfo(
                                        label: "Text de langue requis",
                                        value: valueString(snapshot
                                            .data![index].testDeLangueRequis),
                                      ),
                                      LineInfo(
                                        label: "Debut de periode d'admission",
                                        value: valueString(snapshot.data![index]
                                            .debutPeriodeAdmission),
                                      ),
                                      LineInfo(
                                        label: "Fin de la période d'admission",
                                        value: valueString(snapshot
                                            .data![index].finPeriodeAdmission),
                                      ),
                                      LineInfo(
                                          label: "Nom du pays",
                                          value: valueString(
                                              snapshot.data![index].nomPays)),
                                      LineInfo(
                                          label: "Rentrée",
                                          value: valueString(
                                              snapshot.data![index].rentree)),
                                      LineInfo(
                                          label: "Campus",
                                          value: valueString(
                                              snapshot.data![index].campus)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(TVSizes.md),
                        ));
                  },
                  leading: const Image(
                      image: AssetImage(TVImagesString.ecole),
                      height: 35,
                      width: 35),
                  title: Text(snapshot.data![index].nom),
                  subtitle: Text(snapshot.data![index].nomPays),
                  trailing: const Icon(Iconsax.arrow_right_3),
                );
              },
            );
          } else {
            return const Center(child: Text("Une erreur est survenue"));
          }
        },
      ),
    );
  }
}
