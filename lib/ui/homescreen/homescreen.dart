import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import '../../extensions/datetimeextensions.dart';
import '../../extensions/stringextensions.dart';
import '../../ui/homescreen/homeviewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  String text = "Service ON";
  @override
  void initState() {
    super.initState();
    HomeViewModel vm;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      vm = Provider.of<HomeViewModel>(context, listen: false);
      vm.fetchNewBorn();
      controller.addListener(() {
        if (controller.position.maxScrollExtent == controller.offset) {
          vm.fetchNewBorn();
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Borns"),
        backgroundColor: const Color(0xFFF9923B),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () async {
              final service = FlutterBackgroundService();
              final isRunning = await service.isRunning();
              if(isRunning) {
                service.invoke("stopService");
              } else {
                service.startService();
              }
              if (!isRunning) {
                text = "Service OFF";
              } else {
                text = "Service ON";
              }
              setState(() {});
            },
            child: Text(text),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFFBF8),
      body: RefreshIndicator(
          onRefresh: () => vm.refresh(),
          child: vm.isLoading && vm.newborns.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.separated(
                  controller: controller,
                  itemBuilder: ((context, index) {
                    return index < vm.newborns.length
                        ? ListTile(
                            title: Text(
                              vm.newborns[index].attributes!.name!.capitalize,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0),
                            ),
                            subtitle: Text(
                              vm.newborns[index].attributes!.gender!.capitalize,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13.0),
                            ),
                            trailing: Text(
                              "DOB: ${vm.newborns[index].attributes!.gestation!.toFormattedDate}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.0),
                            ),
                          )
                        // NewbornCard(data: vm.newborns[index])
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                  }),
                  separatorBuilder: (context, index) {
                    return index < vm.newborns.length
                        ? const Divider(
                            color: Colors.grey,
                          )
                        : const SizedBox();
                  },
                  itemCount:
                      vm.hasMore ? vm.newborns.length + 1 : vm.newborns.length,
                )),
    );
  }
}
