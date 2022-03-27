import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const data = [
      Text("Alex Oxlade-Chamberlain",
          maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LIV"),
      Text("AM"),
      Text("15"),
      Text("30"),
      Text("England", maxLines: 2),
      Text("Donny van de Beek", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("EVE"),
      Text("CM"),
      Text("30"),
      Text("24"),
      Text("Netherlands", maxLines: 2),
      Text("Jonny Evans", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LEI"),
      Text("CB"),
      Text("6"),
      Text("34"),
      Text("Northern Ireland", maxLines: 2),
      Text("Trent Alexander-Arnold",
          maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LIV"),
      Text("RB"),
      Text("66"),
      Text("21"),
      Text("England", maxLines: 2),
      Text("Andrew Robertson", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LIV"),
      Text("LB"),
      Text("27"),
      Text("30"),
      Text("Scotland", maxLines: 2),
      Text("Timo Werner", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("CHE"),
      Text("AM"),
      Text("11"),
      Text("25"),
      Text("Germany", maxLines: 2),
      Text("Heung-Min Son", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("TOT"),
      Text("LW"),
      Text("7"),
      Text("29"),
      Text("Korea, South", maxLines: 2),
      Text("Asmir Begovic", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("EVE"),
      Text("GK"),
      Text("15"),
      Text("34"),
      Text("Bosnia-Herzegovina", maxLines: 1, overflow: TextOverflow.ellipsis),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.premPurple,
        title: const Text(
          TextConstants.gameTitle,
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                //Bring up help widget
              })
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ChangeNotifierProvider<PlayerViewModel>(
          create: (context) => PlayerViewModel(),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * .1,
                        bottom: MediaQuery.of(context).size.width * .1),
                    child: const Text(
                      TextConstants.gameSubtitle,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .1,
                        right: MediaQuery.of(context).size.width * .1),
                    child: const SearchBox(),
                  ),
                  /* Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * .1),
                      child: const Text('Blocks will go from here to bottom',
                          style: TextStyle(
                              fontSize: 24,
                              backgroundColor: Themes.premGreen))), */
                  /*
                  DataTable
                   DataTable(columnSpacing: 10, columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text("Team")),
                    DataColumn(label: Text("Position")),
                    DataColumn(label: Text("Number")),
                    DataColumn(label: Text("Age")),
                    DataColumn(label: Text("Country"))
                  ], rows: const [
                    DataRow(cells: [
                      DataCell(Text("Alex Oxlade-Chamberlain")),
                      DataCell(Text(
                        "BHA",
                        style: TextStyle(backgroundColor: Themes.guessGreen),
                      )),
                      DataCell(Text("AM")),
                      DataCell(Text("99")),
                      DataCell(Text("99")),
                      DataCell(Text("Dominican Republic")),
                    ])
                  ]) */
                  /* Expandable/Flexible Rows
                  Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Name"),
                        Spacer(),
                        Text("Team"),
                        Spacer(),
                        Text("Position"),
                        Spacer(),
                        Text("Number"),
                        Spacer(),
                        Text("Age"),
                        Spacer(),
                        Text("Country"),
                      ]),
                  //Example Row with extremes
                  Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Text("Alex Oxlade-Chamberlain"), flex: 2),
                        Spacer(),
                        Text("BHA"),
                        Spacer(),
                        Text("AM"),
                        Spacer(),
                        Text("18"),
                        Spacer(),
                        Text("27"),
                        Spacer(),
                        Text("Dominican Republic"),
                      ]), */
                  /* Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(
                          child: Text("Alex Oxlade-Chamberlain"),
                          flex: 2,
                        ),
                        Flexible(child: Text("BHA")),
                        Flexible(child: Text("AM")),
                        Flexible(child: Text("18")),
                        Flexible(child: Text("27")),
                        Flexible(child: Text("Dominican Republic"), flex: 2),
                      ]) ,*/
                  /* Dynamic test
                   Consumer<PlayerViewModel>(
                    builder: (context, model, child) {
                      return Row(children: [
                        Expanded(
                            child: Text(
                          model.todaysPlayer.name,
                          style: TextStyle(fontSize: 10),
                        )),
                        Expanded(child: Text(model.todaysPlayer.team)),
                        Expanded(child: Text(model.todaysPlayer.position)),
                        Expanded(
                            child: Text(model.todaysPlayer.shirtNumber.toString())),
                        Expanded(child: Text(model.todaysPlayer.age.toString())),
                        Expanded(child: Text(model.todaysPlayer.country)),
                      ]);
                    },
                    //child: ,
                  ), */
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .1),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Name"),
                      Text("Team"),
                      Text("Position"),
                      Text("Number"),
                      Text("Age"),
                      Text("Country"),
                    ]),
              ),
              const Divider(
                height: 10,
                thickness: 10,
                color: Themes.premPurple,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width * 1.66) /
                              MediaQuery.of(context).size.height,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Themes.guessYellow,
                          ),
                          child: data[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
