import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:the_vision/services/detail_folder_service_patch.dart';
import 'package:the_vision/utils/helpers/convert_to_percent.dart';
import 'package:the_vision/utils/helpers/format_price.dart';
import 'package:the_vision/views/app/image_viewer.dart';
import 'package:the_vision/views/app/pdf_viewer.dart';
import 'package:the_vision/views/app/receipts.dart';

class DetailFolderScreen extends StatefulWidget {
  const DetailFolderScreen({super.key});

  @override
  _DetailFolderScreenState createState() => _DetailFolderScreenState();
}

class _DetailFolderScreenState extends State<DetailFolderScreen> {
  late Future<DetailFolderData> futureFolder;
  late DetailFolderData folder;

  @override
  void initState() {
    futureFolder =
        DetailFolderService().getDetailFolder(Get.arguments["code"]!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Dossier N°${Get.arguments["code"]}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<DetailFolderData>(
              future: futureFolder,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  double totalMontantAPayer = 0, resteAVerser = 0;
                  if (snapshot.hasData) {
                    totalMontantAPayer =
                        snapshot.data!.motifPayments.fold<double>(
                      0,
                      (previousValue, element) =>
                          previousValue + double.parse(element.montantAPayer),
                    );
                    resteAVerser = totalMontantAPayer -
                        double.parse(snapshot.data!.montantPaid ?? "0");
                  }
                  return snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.red.shade400,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.folder.profilUser),
                                radius: 40,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(snapshot.data!.folder.firstname,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      )),
                                  Text(snapshot.data!.folder.lastname,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      )),
                                  Text(snapshot.data!.folder.email,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red.shade900)),
                                  Text(snapshot.data!.folder.telephone,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red.shade900)),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.red.shade900,
                            ),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Destination",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red.shade900),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data!.destinations[0].pNom
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Image.network(
                                          snapshot
                                              .data!.destinations[0].flagUrl,
                                          width: 30,
                                          height: 70),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Motif",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red.shade900),
                                  ),
                                  Text(
                                    snapshot.data!.folder.libelle.toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Filière",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red.shade900),
                                  ),
                                  ...snapshot.data!.filieres.map(
                                    (filiere) => (Text(filiere.intitule,
                                        style: const TextStyle(fontSize: 16))),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            const Divider(
                              color: Colors.red,
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 5),
                                Icon(
                                  Iconsax.book5,
                                  size: 18,
                                  color: Colors.red.shade900,
                                ),
                                const SizedBox(width: 2),
                                Text("Evolution du dossier".toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: CircularPercentIndicator(
                                radius: 70.0,
                                lineWidth: 13.0,
                                animation: true,
                                percent: convertStringToDoublePercentage(
                                    snapshot.data!.percentPayment.toString()),
                                // ignore: prefer_const_constructors
                                center: Text(
                                  "${snapshot.data!.percentPayment}%",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                footer: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      snapshot.data!.folder.statusText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          color: Colors.green.shade600),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Mise à jour le ${snapshot.data!.folder.lastUpdate}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.green,
                              ),
                            ),
                            const Divider(
                              color: Colors.red,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 18,
                                  color: Colors.red.shade900,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Agence".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.folder.agNom,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data!.folder.agContact
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        snapshot.data!.folder.agAdresse
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Agent",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red.shade900),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${snapshot.data!.folder.uInitFirstname} ${snapshot.data!.folder.uInitLastname}"
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        snapshot.data!.folder.uInitTelephone
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.red,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.document_scanner,
                                  size: 18,
                                  color: Colors.red.shade900,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Informations fournies au dossier"
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ...snapshot.data!.infosSupp.map(
                              (infoSupp) => Center(
                                child: Column(
                                  children: [
                                    Text(infoSupp.question),
                                    const SizedBox(height: 10),
                                    Text(infoSupp.reponse.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.red,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.document_scanner,
                                  size: 18,
                                  color: Colors.red.shade900,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Documents fournies au dossier".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Table(
                              children: [
                                ...snapshot.data!.documents.map(
                                  (doc) => TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(doc.dpNom.toUpperCase()),
                                      ),
                                      doc.source.isNotEmpty
                                          ? TextButton(
                                              // onPressed: () async {
                                              //   await FileDownloader
                                              //       .downloadFile(
                                              //           url: doc.source,
                                              //           name: doc.dpNom,
                                              //           onDownloadRequestIdReceived:
                                              //               (int id) {
                                              //             Get.snackbar(
                                              //               "The vision",
                                              //               "Telechargement lancé.",
                                              //             );
                                              //           },
                                              //           onDownloadCompleted:
                                              //               (String path) {
                                              //             Get.snackbar(
                                              //               "Telechargement terminé.",
                                              //               "Le document a été téléchargé: $path",
                                              //             );
                                              //           });
                                              // },
                                              onPressed: () {
                                                doc.ext == "pdf"
                                                    ? Get.to(
                                                        () => const PDFScreen(),
                                                        arguments: {
                                                            "path": doc.source,
                                                          })
                                                    : Get.to(
                                                        () =>
                                                            const ImageViewerScreen(),
                                                        arguments: {
                                                            "path": doc.source,
                                                            "name": doc.dpNom,
                                                          });
                                              },
                                              child: doc.ext == "pdf"
                                                  ? const Text(
                                                      "Ouvrir le PDF",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    )
                                                  : const Text(
                                                      "Ouvrir l'image",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                            )
                                          : const Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Text("n/a")
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              color: Colors.red,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.paid,
                                  size: 18,
                                  color: Colors.red.shade900,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Informations de paiement".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(0.34),
                                1: FlexColumnWidth(0.2),
                                2: FlexColumnWidth(0.1),
                                3: FlexColumnWidth(0.18),
                                4: FlexColumnWidth(0.2),
                                5: FlexColumnWidth(0.2),
                              },
                              border: TableBorder.all(),
                              children: [
                                const TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Motif",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Montant",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "TVA",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Remise",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "NAP",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                ...snapshot.data!.motifPayments.map(
                                  (motifPayment) => TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          motifPayment.intitule,
                                          style: const TextStyle(fontSize: 7.5),
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${formatPrice(num.parse(motifPayment.montant))} FCFA",
                                            style:
                                                const TextStyle(fontSize: 7.5),
                                          )),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          motifPayment.tva.toString(),
                                          style: const TextStyle(fontSize: 7.5),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${motifPayment.remise} %",
                                          style: const TextStyle(fontSize: 7.5),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          formatPrice(double.parse(
                                              motifPayment.montantAPayer)),
                                          style: const TextStyle(fontSize: 7.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(""),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(""),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(""),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(3, 8, 3, 3),
                                    child: Text(
                                      "TOTAL",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 7.5),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding:
                                        const EdgeInsets.fromLTRB(3, 8, 3, 3),
                                    child: Text(
                                      formatPrice(totalMontantAPayer),
                                      style: const TextStyle(fontSize: 7.5),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(""),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(""),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(""),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(3, 8, 3, 3),
                                    child: Text(
                                      "Montant versé",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 7.5),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding:
                                        const EdgeInsets.fromLTRB(3, 8, 3, 3),
                                    child: Text(
                                      "${snapshot.data!.montantPaid ?? "0"} FCFA",
                                      style: const TextStyle(fontSize: 7.5),
                                    ),
                                  ),
                                ]),
                                TableRow(
                                  children: [
                                    const Text(""),
                                    const Text(""),
                                    const Text(""),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(3, 4, 3, 3),
                                      child: Text(
                                        "Reste à verser",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 7.5),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding:
                                          const EdgeInsets.fromLTRB(3, 4, 3, 3),
                                      child: Text(
                                        formatPrice(resteAVerser),
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 7.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(
                                child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => const ReceiptScreen(),
                                    arguments: {"code": Get.arguments["code"]});
                              },
                              child: const Text("Consulter vos reçus"),
                            )),
                          ],
                        )
                      : FutureBuilder<DetailFolderData>(
                          future: futureFolder,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              folder = snapshot.data!;
                              return Center(
                                  child:
                                      Text("Dossier ${folder.folder.libelle}"));
                            } else {
                              return const Center(child: Text("Dossier..."));
                            }
                          },
                        );
                } else {
                  return const Center(child: Text("Dossier non trouvé"));
                }
              }),
        ),
      ),
    );
  }
}

class DocHeader extends StatelessWidget {
  const DocHeader({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 20,
          thickness: 1,
          endIndent: 0,
          color: Colors.black12,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          endIndent: 0,
          color: Colors.black12,
        ),
      ],
    );
  }
}

class LineInfo extends StatelessWidget {
  const LineInfo({
    super.key,
    required this.label,
    required this.value,
  });
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          value.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
