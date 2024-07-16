import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_vision/services/parthners_service.dart';
import 'package:the_vision/utils/constants/images_string.dart';
import 'package:the_vision/utils/constants/sizes.dart';
import 'package:the_vision/views/app/detail_folder.dart';

class ParthnersScreen extends StatefulWidget {
  const ParthnersScreen({super.key});

  @override
  _ParthnersScreenState createState() => _ParthnersScreenState();
}

class _ParthnersScreenState extends State<ParthnersScreen> {
  late Future<List<Partner>> futurePartners;

  @override
  void initState() {
    super.initState();
    futurePartners = PartnersService().getPartners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.green.shade100,
          title: const Text("Nos partenaires"),
        ),
        body: FutureBuilder<List<Partner>>(
          future: futurePartners,
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
                    leading: const Image(
                        image: AssetImage(TVImagesString.pathners),
                        height: 35,
                        width: 35),
                    title: Text(snapshot.data![index].nom),
                    subtitle: Text(snapshot.data![index].adresse),
                    trailing: const Icon(Iconsax.arrow_right_3),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(TVSizes.md),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        height: 60,
                                        width: 60,
                                        snapshot.data![index].logo ??
                                            'https://placehold.co/80x40/png',
                                      ),
                                      Text(
                                        snapshot.data![index].nom,
                                        style: const TextStyle(
                                            fontSize: TVSizes.fontLg,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      LineInfo(
                                          label: "Adresse",
                                          value: snapshot.data![index].adresse),
                                      LineInfo(
                                          label: "Contact",
                                          value: snapshot.data![index].contact),
                                    ],
                                  ),
                                ),
                              )));
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("Une erreur est survenue"));
            }
          },
        ));
  }
}
