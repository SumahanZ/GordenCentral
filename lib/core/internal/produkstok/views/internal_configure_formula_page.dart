import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalConfigureFormulaPage extends StatefulWidget {
  const InternalConfigureFormulaPage({super.key});

  @override
  State<InternalConfigureFormulaPage> createState() =>
      _InternalConfigureFormulaPageState();
}

//fetch formulaSettings current
//fetch salesData count, and put here

class _InternalConfigureFormulaPageState
    extends State<InternalConfigureFormulaPage> {
  double _value = 50;
  String selectedRoleDropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configure Formula Page",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              children: [
                const TopSectionAuth(
                    name: "Configure Formula",
                    description:
                        "Configure the formula of the Safety Stock and Reorder Point Method",
                    isAvatarNeeded: false),
                const SizedBox(height: 30),
                //enter penjelasan rumus here
                const SafetyStockFormulaWidget(),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Service Level",
                    style: appStyle(
                      size: 18,
                      color: mainBlack,
                      fw: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SfSlider(
                  min: 0.0,
                  stepSize: 1,
                  max: 100.0,
                  value: _value,
                  interval: 20,
                  showTicks: false,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Window Size",
                    style: appStyle(
                      size: 18,
                      color: mainBlack,
                      fw: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SfSlider(
                  min: 0.0,
                  stepSize: 1,
                  max: 100.0,
                  value: _value,
                  interval: 20,
                  showTicks: false,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Confirm",
                    style: appStyle(
                        size: 16, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SafetyStockFormulaWidget extends StatelessWidget {
  const SafetyStockFormulaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeXView(
      child: TeXViewColumn(children: [
        TeXViewInkWell(
          id: "id_0",
          child: TeXViewColumn(children: [
            TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
                style: TeXViewStyle(textAlign: TeXViewTextAlign.center)),
            TeXViewContainer(
              child: TeXViewImage.network(
                  'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
              style: TeXViewStyle(
                margin: TeXViewMargin.all(10),
                borderRadius: TeXViewBorderRadius.all(20),
              ),
            ),
            TeXViewDocument(r"""<p>                                
                       When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                       $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
                style: TeXViewStyle.fromCSS(
                    'padding: 15px; color: white; background: green'))
          ]),
        )
      ]),
      style: TeXViewStyle(
        elevation: 10,
        borderRadius: TeXViewBorderRadius.all(25),
        border: TeXViewBorder.all(TeXViewBorderDecoration(
            borderColor: Colors.blue,
            borderStyle: TeXViewBorderStyle.solid,
            borderWidth: 5)),
        backgroundColor: Colors.white,
      ),
    );
  }
}
